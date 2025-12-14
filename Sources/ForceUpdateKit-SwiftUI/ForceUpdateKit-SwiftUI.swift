import Foundation
import SwiftUI
import Combine
import ControlKitBase
#if canImport(UIKit)
import UIKit
#endif

public let forceUpdateKit_Version: String = "1.0.0"
@MainActor
public class ForceUpdateKit: AnyObject, @MainActor Updatable {
    // MARK: - Properties
    public let updateService: GenericServiceProtocol!
    private var currentConfig: UpdateServiceConfig?
    private var currentMaxRetries: Int = 5
    private var currentRetryCount: Int = 0
    nonisolated(unsafe) private static var sharedInstance: ForceUpdateKit?
    private let presenter = ForceUpdatePresenter.shared
    
    // MARK: - Initialization
    public init(updateService: GenericServiceProtocol = GenericService()) {
        self.updateService = updateService
        ForceUpdateKit.sharedInstance = self
    }
    
    // MARK: - Public Configuration
    @MainActor
    public func configure(config: UpdateServiceConfig, maxRetries: Int = 5) async {
        self.currentConfig = config
        self.currentMaxRetries = maxRetries
        self.currentRetryCount = 0
        
        await configureWithRetry()
    }
    
    // MARK: - Private Force Update Logic
    @MainActor
    private func configureWithRetry() async {
        guard let config = currentConfig else { 
            return 
        }
        
        let request = UpdateRequest(appId: config.appId)
        
        do {
            let response = try await self.update(request: request)
            if response.isSuccess {
                await successResponse(config: config, response: response)
            } else {
                showRetryView()
            }
        } catch {
            showRetryView()
        }
    }
    
    @MainActor
    private func showRetryView() {
        guard let config = currentConfig else { return }
        
        presenter.dismissRetry()
        
        presenter.presentRetry(config: config.viewConfig, retryAction: {
            guard let sharedInstance = ForceUpdateKit.sharedInstance else {
                return
            }
            
            Task { @MainActor in
                sharedInstance.presenter.dismissRetry()
                sharedInstance.currentRetryCount += 1
                if sharedInstance.currentRetryCount <= sharedInstance.currentMaxRetries {
                    await sharedInstance.configureWithRetry()
                } else {
                    sharedInstance.showMaxRetriesReached()
                }
            }
        })
    }
    
    @MainActor
    private func showMaxRetriesReached() {
        guard let config = currentConfig else { return }
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            let alert = UIAlertController(
                title: config.viewConfig.maxRetriesAlertTitle,
                message: config.viewConfig.maxRetriesAlertMessage,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: config.viewConfig.maxRetriesAlertButtonTitle, style: .default))
            rootViewController.present(alert, animated: true)
        }
    }
    
    @MainActor
    private func successResponse(config: UpdateServiceConfig, response: Result<UpdateResponse>) async {
        presenter.dismissRetry()
        guard let res = response.value else { return }
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: config,
            response: res
        )
        do {
            if response.value?.data != nil {
                // Wait for presenter to update config if needed
                try await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
                
                let forceUpdateView = ForceUpdateViewStyle.make(
                    viewModel: viewModel,
                    config: config.viewConfig
                )
                
                presenter.presentForceUpdate(forceUpdateView)
            }
        } catch {}
    }
}

// MARK: - SwiftUI View Modifier
public struct ForceUpdateModifier: ViewModifier {
    @StateObject private var presenter = ForceUpdatePresenter.shared
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if presenter.showForceUpdate, let view = presenter.forceUpdateView {
                        view
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 1.0), value: presenter.showForceUpdate)
                    }
                    
                    if presenter.showRetry, 
                       let retryConfig = presenter.retryConfig,
                       let retryAction = presenter.retryAction {
                        RetryConnectionView(
                            config: retryConfig,
                            retryAction: retryAction
                        )
                        .transition(.opacity)
                        .animation(.easeOut(duration: 0.3), value: presenter.showRetry)
                    }
                }
            )
    }
}

public extension View {
    func forceUpdateOverlay() -> some View {
        modifier(ForceUpdateModifier())
    }
}

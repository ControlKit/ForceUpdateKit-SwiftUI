import Foundation
import SwiftUI
import Combine
import ControlKitBase

public let forceUpdateKit_Version: String = "1.0.0"
@MainActor
public class ForceUpdateKit: AnyObject, @MainActor Updatable {
    // MARK: - Properties
    public let updateService: GenericServiceProtocol!
    private var config: UpdateServiceConfig?
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
    public func configure(config: UpdateServiceConfig, maxRetries: Int = 5) async -> AnyView {
        self.config = config
        self.currentMaxRetries = maxRetries
        self.currentRetryCount = 0
        
        return await configureWithRetry()
    }
    
    // MARK: - Private Force Update Logic
    private func configureWithRetry() async -> AnyView {
        guard let currentConfig = config else {
            return AnyView(Text(""))
        }
        
        let request = UpdateRequest(appId: currentConfig.appId)
        
        do {
            let response = try await self.update(request: request)
            if response.isSuccess {
                return await successResponse(config: currentConfig, response: response)
            } else {
                return await showRetryView()
            }
        } catch {
            return await showRetryView()
        }
    }
    
    private func showRetryView() async -> AnyView {
        guard let currentConfig = config else {
            return AnyView(Text(""))
        }
        
        presenter.dismissRetry()
        
        return AnyView(
            RetryConnectionView(
                config: currentConfig.viewConfig,
                retryAction: {
                    guard let sharedInstance = ForceUpdateKit.sharedInstance else {
                        return
                    }
                    
                    Task { @MainActor in
                        sharedInstance.presenter.dismissRetry()
                        sharedInstance.currentRetryCount += 1
                        if sharedInstance.currentRetryCount <= sharedInstance.currentMaxRetries {
                            _ = await sharedInstance.configureWithRetry()
                        } else {
                            _ = await sharedInstance.showMaxRetriesReached()
                        }
                    }
                }
            )
        )
    }
    
    private func showMaxRetriesReached() async -> AnyView {
        guard let currentConfig = config else {
            return AnyView(Text(""))
        }
        
        return AnyView(
            MaxRetriesReachedView(
                title: currentConfig.viewConfig.maxRetriesAlertTitle,
                message: currentConfig.viewConfig.maxRetriesAlertMessage,
                buttonTitle: currentConfig.viewConfig.maxRetriesAlertButtonTitle
            )
        )
    }
    
    private func successResponse(config: UpdateServiceConfig, response: Result<UpdateResponse>) async -> AnyView {
        presenter.dismissRetry()
        guard let res = response.value else { 
            return AnyView(Text(""))
        }
        
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: config,
            response: res
        )
        
        if response.value?.data != nil {
            let forceUpdateView = ForceUpdateViewStyle.make(
                viewModel: viewModel,
                config: config.viewConfig
            )
            
            return AnyView(forceUpdateView)
        } else {
            return AnyView(Text(""))
        }
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

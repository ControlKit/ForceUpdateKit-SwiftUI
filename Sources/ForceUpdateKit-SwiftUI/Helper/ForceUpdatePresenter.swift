//
//  ForceUpdatePresenter.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import SwiftUI

@MainActor
public class ForceUpdatePresenter: ObservableObject {
    @Published var showForceUpdate: Bool = false
    @Published var showRetry: Bool = false
    @Published var forceUpdateView: AnyView?
    @Published var retryConfig: ForceUpdateViewConfig?
    @Published var retryAction: (() -> Void)?
    
    static let shared = ForceUpdatePresenter()
    
    func presentForceUpdate<Content: View>(_ view: Content) {
        forceUpdateView = AnyView(view)
        withAnimation {
            showForceUpdate = true
        }
    }
    
    func presentRetry(config: ForceUpdateViewConfig, retryAction: @escaping () -> Void) {
        retryConfig = config
        self.retryAction = retryAction
        withAnimation {
            showRetry = true
        }
    }
    
    func dismissRetry() {
        withAnimation {
            showRetry = false
        }
    }
    
    func dismissForceUpdate() {
        withAnimation {
            showForceUpdate = false
        }
    }
}


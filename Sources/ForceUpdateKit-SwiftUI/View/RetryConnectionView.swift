//
//  RetryConnectionView.swift
//  ForceUpdateKit
//
//  Created by Test Suite on 2024.
//

import Foundation
import SwiftUI
import ControlKitBase

public struct RetryConnectionView: View {
    var config: ForceUpdateViewConfig
    var retryAction: () -> Void
    var dismissAction: (() -> Void)?
    
    public init(config: ForceUpdateViewConfig, retryAction: @escaping () -> Void, dismissAction: (() -> Void)? = nil) {
        self.config = config
        self.retryAction = retryAction
        self.dismissAction = dismissAction
    }
    
    public var body: some View {
        ZStack {
            config.retryBackgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 200)
                
                // Icon
                Group {
                    if let customImage = config.retryIconImage {
                        customImage
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(config.retryIconColor)
                    } else if let image = ImageHelper.image(config.retryIconName) {
                        image
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(config.retryIconColor)
                    } else {
                        Image(systemName: "wifi.slash")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(config.retryIconColor)
                    }
                }
                .frame(width: config.retryIconSize.width, height: config.retryIconSize.height)
                .padding(.bottom, 45)
                
                // Title
                Text(config.retryTitleText)
                    .font(config.retryTitleFont)
                    .foregroundColor(config.retryTitleColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 18)
                
                // Message
                Text(config.retryMessageText)
                    .font(config.retryMessageFont)
                    .foregroundColor(config.retryMessageColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 60)
                
                // Retry Button
                Button(action: {
                    retryAction()
                }) {
                    Text(config.retryButtonTitle)
                        .font(config.retryButtonFont)
                        .foregroundColor(config.retryButtonTitleColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(config.retryButtonBackgroundColor)
                        .cornerRadius(config.retryButtonCornerRadius)
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
        }
        .transition(.opacity)
    }
}

//
//  File.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import SwiftUI
import ControlKitBase

public struct ForceUpdateView_FullScreen4: View, ForceUpdateViewProtocol {
    @State private var config: ForceUpdateViewConfig
    var viewModel: ForceUpdateViewModel
    
    public init(viewModel: ForceUpdateViewModel, config: ForceUpdateViewConfig) {
        self.viewModel = viewModel
        let updatedConfig = ForceUpdateViewPresenter(data: viewModel.response.data, config: config).config
        self._config = State(initialValue: updatedConfig)
    }
    
    public var body: some View {
        ZStack {
            if let bgImage = config.contentBackGroundImage {
                bgImage
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                iconView(
                    color: config.updateImageColor,
                    image: config.icon,
                    imageType: config.updateImageType
                )
                .frame(width: 191, height: 139)
                .padding(.top, 100)
                
                Text(config.headerTitle)
                    .font(config.headerTitleFont)
                    .foregroundColor(config.headerTitleColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.top, 31)
                
                Text(config.descriptionText)
                    .font(config.descriptionFont)
                    .foregroundColor(config.descriptionTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                Spacer()
                Button(action: {
                    viewModel.openLink()
                    viewModel.setAction(.update)
                }) {
                    Text(config.updateButtonNortmalTitle)
                        .font(config.updateButtonFont)
                        .foregroundColor(config.updateButtonTitleColor)
                        .frame(width: 222, height: 56)
                        .background(config.updateButtonBackColor)
                        .cornerRadius(config.updateButtonCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: config.updateButtonCornerRadius)
                                .stroke(config.updateButtonBorderColor, lineWidth: config.updateButtonBorderWidth)
                        )
                }
                .padding(.bottom, 10)
                
                Text(config.versionText)
                    .font(config.versionFont)
                    .foregroundColor(config.versionTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 52)
            }
            .background(config.contentViewBackColor)
            .cornerRadius(20)
            .ignoresSafeArea()
        }
        .onAppear {
            viewModel.setAction(.view)
        }
        .ignoresSafeArea()
    }
}

open class FullScreen4ForceUpdateViewConfig: ForceUpdateViewConfig {
    public override init(lang: CKLanguage) {
        super.init(lang: lang)
        style = .fullscreen4
    }
}

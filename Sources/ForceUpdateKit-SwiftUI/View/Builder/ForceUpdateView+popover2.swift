//
//  File.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import SwiftUI
import ControlKitBase

public struct ForceUpdateView_Popover2: View, ForceUpdateViewProtocol {
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
            
            config.contentViewBackColor
                .opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    iconView(
                        color: config.updateImageColor,
                        image: config.icon,
                        imageType: config.updateImageType
                    )
                        .frame(width: 64, height: 63)
                        .padding(.top, 66)
                        .padding(.bottom, 41)
                    
                    Text(config.headerTitle)
                        .font(config.headerTitleFont)
                        .foregroundColor(config.headerTitleColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)
                    
                    Text(config.descriptionText)
                        .font(config.descriptionFont)
                        .foregroundColor(config.descriptionTextColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 50)
                    
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
                }
                .frame(height: 433)
                .frame(maxWidth: .infinity)
                .background(config.popupViewBackColor)
                .cornerRadius(config.popupViewCornerRadius)
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            viewModel.setAction(.view)
        }
    }
}

open class Popover2ForceUpdateViewConfig: ForceUpdateViewConfig {
    public override init(lang: CKLanguage) {
        super.init(lang: lang)
        style = .popover2
        contentViewBackColor = .black
        popupViewBackColor = .black
        headerTitleColor = .white
        updateImageType = .gear
        updateImageColor = .orange
        updateButtonBackColor = .orange
        versionTextColor = .orange
    }
}

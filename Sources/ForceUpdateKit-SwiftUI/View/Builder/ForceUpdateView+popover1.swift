//
//  File.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import SwiftUI
import ControlKitBase

public struct ForceUpdateView_Popover1: ForceUpdateViewProtocol {
    @State private var config: ForceUpdateViewConfig
    var viewModel: ForceUpdateViewModel
    
    public init(viewModel: ForceUpdateViewModel, config: ForceUpdateViewConfig) {
        self.viewModel = viewModel
        var updatedConfig = ForceUpdateViewPresenter(data: viewModel.response.data, config: config).config
        self._config = State(initialValue: updatedConfig)
    }
    
    @ViewBuilder
    private var updateImage: some View {
        if let color = config.updateImageColor {
            if let img = config.updateImage {
                img
                    .imageWithColor(color)
            } else if let img = ImageHelper.image(config.updateImageType.rawValue) {
                img
                    .imageWithColor(color)
            }
        } else {
            if let img = config.updateImage {
                img
            } else if let img = ImageHelper.image(config.updateImageType.rawValue) {
                img
            }
        }
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
                    updateImage
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

open class Popover1ForceUpdateViewConfig: ForceUpdateViewConfig {
    public override init(lang: CKLanguage) {
        super.init(lang: lang)
        style = .popover1
        contentViewBackColor = .black
        popupViewBackColor = .black
        headerTitleColor = .white
        updateImageType = .gear
        updateImageColor = .orange
        updateButtonBackColor = .orange
        versionTextColor = .orange
    }
}

//
//  ForceUpdateViewStyle.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
import SwiftUI
import ControlKitBase
public enum ForceUpdateViewStyle {
    case fullscreen1
    case fullscreen2
    case fullscreen3
    case fullscreen4
    case popover1
    case popover2
    public static func make(viewModel: ForceUpdateViewModel,
                            config: ForceUpdateViewConfig) -> some ForceUpdateViewProtocol {
        switch config.style {
        case .fullscreen1:
            return ForceUpdateView_FullScreen1(viewModel: viewModel,
                                               config: config)
        case .fullscreen2:
            return ForceUpdateView_FullScreen2(viewModel: viewModel,
                                               config: config)
        case .fullscreen3:
            return ForceUpdateView_FullScreen3(viewModel: viewModel,
                                               config: config)
        case .fullscreen4:
            return ForceUpdateView_FullScreen4(viewModel: viewModel,
                                               config: config)
        case .popover1:
            return ForceUpdateView_Popover1(viewModel: viewModel,
                                            config: config)
        case .popover2:
            return ForceUpdateView_Popover2(viewModel: viewModel,
                                            config: config)
        }
    }
    
    public static func getViewConfigWithStyle(style: ForceUpdateViewStyle, language: CKLanguage) -> ForceUpdateViewConfig {
        switch style {
        case .fullscreen1:
            return FullScreen1ForceUpdateViewConfig(lang: language)
        case .fullscreen2:
            return FullScreen2ForceUpdateViewConfig(lang: language)
        case .fullscreen3:
            return FullScreen3ForceUpdateViewConfig(lang: language)
        case .fullscreen4:
            return FullScreen4ForceUpdateViewConfig(lang: language)
        case .popover1:
            return Popover1ForceUpdateViewConfig(lang: language)
        case .popover2:
            return Popover2ForceUpdateViewConfig(lang: language)
        }
    }
}

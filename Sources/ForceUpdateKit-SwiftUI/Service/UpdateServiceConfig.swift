//
//  UpdateServiceConfig.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
import ControlKitBase
public struct UpdateServiceConfig {
    public init(style: ForceUpdateViewStyle = .fullscreen1,
                appId: String,
                language: CKLanguage) {
        self.viewConfig = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        self.appId = appId
        self.language = language
    }
    public var appId: String
    public var language: CKLanguage
    public var viewConfig: ForceUpdateViewConfig
}

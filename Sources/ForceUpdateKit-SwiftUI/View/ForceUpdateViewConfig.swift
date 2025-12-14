//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 10/18/23.
//

import Foundation
import SwiftUI
import ControlKitBase
open class ForceUpdateViewConfig {
    public init(lang: CKLanguage) {
        self.lang = lang
    }
    public let lang: CKLanguage
    public var style: ForceUpdateViewStyle = .fullscreen1
    public var updateButtonNortmalTitle: String = "Update New Version"
    public var updateButtonSelectedTitle: String = "Update New Version"
    public var updateButtonImage: Image = Image(systemName: "arrow.down.circle")
    public var contentViewBackColor: Color = .white
    public var popupViewBackColor: Color = .black
    public var popupViewCornerRadius: CGFloat = 15.0
    public var contentBackGroundImage: Image?
    public var updateImageType: ImageType = .spaceship1
    public var icon: String?
    public var updateImageColor: Color?
    public var updateButtonFont = Font.system(size: 12, weight: .medium)
    public var headerTitleFont = Font.system(size: 13, weight: .bold)
    public var headerTitle = "It's time to update"
    public var headerTitleColor: Color = .black
    public var descriptionFont = Font.system(size: 12, weight: .medium)
    public var descriptionText = "It's time to update The version you are using is old, need to update the latest version in order to experience new features."
    public var descriptionTextColor: Color = .gray
    public var versionFont = Font.system(size: 10, weight: .bold)
    public var versionText = "Up to 12.349 version Apr 2024."
    public var versionTextColor: Color = .gray
    public var updateButtonBackColor: Color = .blue
    public var lineColor: Color = Color(white: 0.9)
    public var updateButtonTitleColor: Color = .white
    public var updateButtonCornerRadius: CGFloat = 20.0
    public var updateButtonBorderWidth: CGFloat = 0.0
    public var updateButtonBorderColor: Color = .clear
    
    // Retry Connection View Properties
    public var retryBackgroundColor: Color = Color.black.opacity(0.7)
    public var retryContainerBackgroundColor: Color = .white
    public var retryContainerCornerRadius: CGFloat = 16.0
    public var retryIconColor: Color = Color(red: 83/255.0, green: 82/255.0, blue: 82/255.0)
    public var retryTitleText: String = "Connection Error"
    public var retryTitleFont: Font = Font.system(size: 24, weight: .semibold)
    public var retryTitleColor: Color = Color(red: 84/255.0, green: 84/255.0, blue: 84/255.0)
    public var retryMessageText: String = "Please check your internet connection and try again"
    public var retryMessageFont: Font = Font.system(size: 18, weight: .regular)
    public var retryMessageColor: Color = Color(red: 84/255.0, green: 84/255.0, blue: 84/255.0)
    public var retryButtonTitle: String = "Retry"
    public var retryButtonBackgroundColor: Color = Color(red: 145/255.0, green: 145/255.0, blue: 145/255.0)
    public var retryButtonTitleColor: Color = .white
    public var retryButtonCornerRadius: CGFloat = 10.0
    public var retryButtonFont: Font = Font.system(size: 18, weight: .semibold)
    
    // Retry Connection View Icon Properties
    public var retryIconName: String = "no-wifi1"
    public var retryIconImage: Image?
    public var retryIconSize: CGSize = CGSize(width: 64, height: 64)
    
    // Max Retries Reached Alert Properties
    public var maxRetriesAlertTitle: String = "Connection Error"
    public var maxRetriesAlertMessage: String = "Unable to connect to server. Please try again later."
    public var maxRetriesAlertButtonTitle: String = "OK"
}

public enum ImageType: String {
    case spaceship1 = "update-icon"
    case spaceship2 = "spaceship"
    case gear = "gear"
}

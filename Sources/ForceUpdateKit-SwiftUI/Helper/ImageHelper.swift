//
//  ImageHelper.swift
//  ControlKitBase
//
//  Created by Maziar Saadatfar on 9/1/25.
//
import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif
public class ImageHelper {
    public static var resolvedBundle: Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: self)
#endif
    }
    
    public static func image(_ name: String) -> Image? {
        if let _ = UIImage(named: name, in: resolvedBundle, compatibleWith: nil) {
            return Image(name, bundle: resolvedBundle)
        }
        return nil
    }
    
    // Helper to convert UIImage to Image for compatibility
    public static func uiImage(_ name: String) -> UIImage? {
        return UIImage(named: name, in: resolvedBundle, compatibleWith: nil)
    }
    
    public static func swiftUIImage(_ name: String) -> Image? {
        if let uiImage = uiImage(name) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
}


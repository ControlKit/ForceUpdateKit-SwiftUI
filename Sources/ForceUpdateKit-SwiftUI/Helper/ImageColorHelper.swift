//
//  ImageColorHelper.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import SwiftUI

extension Image {
    func imageWithColor(_ color: Color) -> some View {
        self
            .renderingMode(.template)
            .foregroundColor(color)
    }
}


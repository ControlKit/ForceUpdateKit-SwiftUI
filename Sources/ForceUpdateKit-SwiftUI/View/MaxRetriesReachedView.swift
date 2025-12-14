//
//  MaxRetriesReachedView.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import SwiftUI

struct MaxRetriesReachedView: View {
    @State private var showAlert = true
    let title: String
    let message: String
    let buttonTitle: String
    
    var body: some View {
        Color.clear
            .alert(title, isPresented: $showAlert) {
                Button(buttonTitle) {
                    showAlert = false
                }
            } message: {
                Text(message)
            }
    }
}


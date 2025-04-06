//
//  ImageActionButton.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

import SwiftUI

struct ImageActionButton: View {
    let icon: String
    var width: CGFloat = 90
    var height: CGFloat = 90
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .clipShape(Circle())
        }
        .padding()
    }
}

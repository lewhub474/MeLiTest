//
//  ImageActionButton.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

import SwiftUI

struct ImageActionButton: View {
    let icon: String
    var size: CGFloat = 90
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(
                    width: size,
                    height: size
                )
                .clipShape(Circle())
        }
        .padding()
    }
}

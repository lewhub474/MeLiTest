//
//  LocationPopup.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

import SwiftUI

struct LocationPopup: View {
    let city: String
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Estás en:")
                .font(.headline)
            Text(city)
                .font(.title)
                .bold()

            Button("Cerrar") {
                onDismiss()
            }
            .padding(.top, 8)
            .foregroundColor(.white)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(40)
    }
}

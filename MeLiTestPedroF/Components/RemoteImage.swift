//
//  RemoteImage.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import SwiftUI

struct RemoteImage: View {
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Color.black.opacity(0.2)
            }
        }
    }
}

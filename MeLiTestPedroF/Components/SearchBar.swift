//
//  SearchBar.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack() {
            TextField("Buscar artículos...", text: $text)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.95))
                .cornerRadius(10)
                .submitLabel(.search)
            
            ImageActionButton(icon: "searchlogo", width: 70, height: 70,action: onSearch)

        }
        .padding(.horizontal, 8)
    }
}

//
//  SplashScreen.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            DashboardView()
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack {
                    Image("localrocket2") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    Text("Cargando...")
                        .foregroundColor(.teal)
                        .padding(.top, 16)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

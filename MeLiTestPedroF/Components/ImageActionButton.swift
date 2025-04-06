//
//  FloatingActionButton.swift
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

import Foundation
import CoreLocation
import Combine
//
//final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    private let geocoder = CLGeocoder()
//
//    @Published var city: String = ""
//    @Published var locationFetched: Bool = false
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//    }
//
//    func requestLocation() {
//        locationFetched = false
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        
//        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
//            guard let self = self, let placemark = placemarks?.first else { return }
//            DispatchQueue.main.async {
//                self.city = placemark.locality ?? "Ciudad desconocida"
//                self.locationFetched = true
//            }
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error obteniendo ubicación: \(error.localizedDescription)")
//        DispatchQueue.main.async {
//            self.city = "Error obteniendo ubicación"
//            self.locationFetched = true
//        }
//    }
//}
import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    @Published var city: String = ""
    @Published var locationFetched: Bool = false

    private var retryTask: Task<Void, Never>?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        city = "Obteniendo ubicación..."
        locationFetched = false
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self, let placemark = placemarks?.first else { return }
            DispatchQueue.main.async {
                self.city = placemark.locality ?? "Ciudad desconocida"
                self.locationFetched = true
                self.retryTask?.cancel()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error obteniendo ubicación: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.city = "Error obteniendo ubicación"
            self.locationFetched = true
        }
    }

    func startLocationRetryLoop() {
        retryTask?.cancel() // cancela si ya había un loop corriendo

        retryTask = Task {
            while !Task.isCancelled {
                await MainActor.run {
                    self.requestLocation()
                }

                try? await Task.sleep(nanoseconds: 2_000_000_000) // espera 3 segundos

                // Si ya se obtuvo ciudad válida, termina el bucle
                if !city.isEmpty && city != "Error obteniendo ubicación" {
                    break
                }
            }
        }
    }
}


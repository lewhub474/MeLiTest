//
//  LocationRepositoryImpl.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

import CoreLocation
//
//final class LocationRepositoryImpl: NSObject, LocationRepository {
//    private let locationManager = CLLocationManager()
//    private let geocoder = CLGeocoder()
//    
//    private var continuation: CheckedContinuation<String, Error>?
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//    }
//
//    func fetchCity() async throws -> String {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            self.continuation = continuation
//        }
//    }
//}
import CoreLocation

final class LocationRepositoryImpl: NSObject, LocationRepository {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    private var continuation: CheckedContinuation<String, Error>?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func fetchCity() async throws -> String {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        }
    }

    // ✅ NUEVO: función de reintento
    func startRetryingFetchCity(maxRetries: Int = 3, delay: TimeInterval = 2) async throws -> String {
        var retries = 0
        while retries < maxRetries {
            do {
                let city = try await fetchCity()
                if city != "Ciudad desconocida" && !city.isEmpty {
                    return city
                }
            } catch {
                print("Error obteniendo ubicación: \(error.localizedDescription)")
            }

            retries += 1
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        throw NSError(domain: "No se pudo obtener la ciudad después de varios intentos", code: 999)
    }
}

extension LocationRepositoryImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            continuation?.resume(throwing: NSError(domain: "No location", code: 1))
            return
        }

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self else { return }

            if let error {
                print("Error en reverseGeocodeLocation: \(error.localizedDescription)")
                self.continuation?.resume(throwing: error)
                return
            }

            guard let placemark = placemarks?.first else {
                self.continuation?.resume(returning: "Ciudad desconocida")
                return
            }

            let city = placemark.locality ?? "Ciudad desconocida"
            self.continuation?.resume(returning: city)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error obteniendo ubicación: \(error.localizedDescription)")
        continuation?.resume(throwing: error)
    }
}


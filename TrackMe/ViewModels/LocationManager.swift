//
//  LocationManager.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 26/08/2023.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion()
    @Published var locationName: String?
    
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
  
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            location = lastLocation.coordinate
            region = MKCoordinateRegion(
                center: lastLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
//            let geocoder = CLGeocoder()
//                   let location = CLLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
//                   
//                   geocoder.reverseGeocodeLocation(location) { placemarks, error in
//                       if let error = error {
//                           print("Error: \(error.localizedDescription)")
//                       } else if let placemark = placemarks?.first {
//                           let loc = placemark.name ?? "Unknown Area"
//                           self.locationName = loc
//               }
//            }
        }
    }
    
    
    func reverseGeocodeLocation(_ location: CLLocation, completion: (String) -> Void) async {
        let geocoder = CLGeocoder()
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let locationName = placemark.name ?? "Unknown Area"
                completion(locationName)
            } else {
                completion("Unknown Area")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            completion("Unknown Area")
        }
    }
}

//
//  IndividualGroupView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 17/08/2023.
//

import SwiftUI
import MapKit

struct IndividualGroupView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                NavigationLink {
                    Text(location.name)
                } label: {
                    Circle()
                        .stroke(.red, lineWidth: 3)
                        .frame(width: 15, height: 15)
                }
            }
        }
        .navigationTitle("London Explorer")
        .frame(maxHeight: 300 )
    }
}

struct IndividualGroupView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualGroupView()
    }
}
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

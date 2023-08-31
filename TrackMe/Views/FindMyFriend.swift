//
//  FindMyFriend.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 31/08/2023.
//
import SwiftUI
import CoreLocation
import CoreMotion

struct FindMyFriend: View {
    @ObservedObject var locationManager: LocationManager = LocationManager()
    @ObservedObject var motionManager: MotionManager = MotionManager()
    @Binding var userImage: String
    @Binding var userName: String
    @Binding var userLat: String
    @Binding var userLong: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                AsyncImage(url: URL(string: userImage)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 60, maxHeight: 60)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                    case .failure(_):
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray)
                            .frame(maxHeight: 60)
                            .clipShape(Circle())
                    case .empty:
                        ProgressView()
                            .frame(maxHeight: 70)
                    @unknown default:
                        fatalError()
                    }
                }
                .scaledToFill()
                .frame(maxWidth: 60, maxHeight: 60)


                Text("Finding \(userName)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            Spacer()

            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 110, height: 110)
                .rotationEffect(.degrees(calculateDirection()))
                .animation(Animation.easeInOut(duration: 0.1), value: 1)

            Spacer()

            Button(action: {}){
                Text("Found \(userName) ⭐️")
                    .font(.title2)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .foregroundColor(Color("Green"))
                    .cornerRadius(8)
                    .frame(maxHeight: 20)
            } //End of button
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .background(
            LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: Color("Green"), location: 0.2),
                Gradient.Stop(color: Color("LoginTriangleGreen"), location: 0.79),
            ]), startPoint: .bottomTrailing, endPoint: .topLeading))

        }
    private func calculateDirection() -> Double {
        guard let userLocation = locationManager.location else {
            return 0.0
        }

        let userHeading = motionManager.deviceOrientation // in radians
        let userLoc = CLLocationCoordinate2D(latitude: Double(userLat) ?? 0.0, longitude: Double(userLong) ?? 0.0)
        let targetHeading = userLocation.direction(to: userLoc)
        
        // Convert radians to degrees and adjust for the rotation direction
        let degrees = userHeading.radiansToDegrees + targetHeading.radiansToDegrees
        return degrees
    }
}

extension Double {
    var radiansToDegrees: Double { self * 180 / .pi }
    var degreesToRadians: Double { self * .pi / 180 }
}

extension CLLocationCoordinate2D {
    func direction(to coordinate: CLLocationCoordinate2D) -> Double {
        let dx = coordinate.longitude - longitude
        let dy = coordinate.latitude - latitude
        let angle = atan2(dy, dx) // in radians
        return angle
    }
}









struct FindMyFriend_Previews: PreviewProvider {
    static var previews: some View {
        FindMyFriend(userImage: .constant("https://firebasestorage.googleapis.com:443/v0/b/trackme-7f739.appspot.com/o/profileImages%2Fimage_1693086953.519913.jpg?alt=media&token=4b511d29-c098-4d76-88cd-0dbb4261a580"), userName: .constant("Julia"), userLat: .constant("-26.000530743054476"), userLong: .constant("28.006480392094705"))
    }
}
//
//

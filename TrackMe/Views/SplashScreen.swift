import SwiftUI
import MapKit

struct SplashScreen: View {
    @State private var isRotating = -25.0
    private var loadingItem = ["Loading Data...", "Finding Friends...", "Searching for North..."]
    let randomInt: Int = Int.random(in: 0..<3)
    var vm: NavigationNavigationVm = NavigationNavigationVm()
    @AppStorage("hasOpened") var hasOpened: Bool = false
    @State var isActive: Bool = false
    @ObservedObject var userVm: UsersViewModel = UsersViewModel()
    @StateObject var locationManager = LocationManager()
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        ZStack {
            if isActive {
                vm.nextScreen
            } else {
                VStack {
                    Text("Track me")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height: 20)
                    ZStack {
                        Image("CompassOuter")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 190, alignment: .center)
                            .padding(.bottom, 29)
                        Image("CompassInner")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 125)
                            .rotationEffect(Angle(degrees: isRotating), anchor: .center)
                            .onAppear {
                                withAnimation(.linear(duration: 1).speed(0.4).repeatForever(autoreverses: true)) {
                                    isRotating = 25.0
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 30)
                    Ellipse()
                        .fill(
                            LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: Color("DarkGreen"), location: 0.7),
                                Gradient.Stop(color: .black, location: 1.1),
                            ]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 120, height: 25)
                        .padding(.top, -70)
                        .foregroundColor(.clear)

                    Text(loadingItem[randomInt])
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color("Green"), location: 0.1),
                        Gradient.Stop(color: .black, location: 1.6),
                    ]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    vm.navigateToNextScreen(hasOpened: hasOpened)
                    isActive = true
                }
                if let userLocation = locationManager.location {
                    mapRegion.center = userLocation
                    print(mapRegion.center)
                    userVm.updateUserLocation(lat: String(describing: mapRegion.center.latitude), long: String(describing: mapRegion.center.longitude))
                }
                UserDefaults.standard.set(true, forKey: "hasOpened")
            }
        }
    }
}
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

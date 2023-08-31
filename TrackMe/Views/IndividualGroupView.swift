//
//  IndividualGroupView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 17/08/2023.
//

import SwiftUI
import MapKit

struct IndividualGroupView: View {
    @Binding var groupId: String?
    @StateObject var vm: GroupsViewModel = GroupsViewModel();
    @StateObject var locationManager = LocationManager()
    @State var groupData: GroupsModel?
    @State var shouldSHow: Bool = false
    @State var members: [personModel] = []
    @State var tracking: MapUserTrackingMode = .follow
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
   
    
    var body: some View {
        VStack{
            if(shouldSHow){
                Map(
                    coordinateRegion: $mapRegion,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking,
                    annotationItems: members,
                    annotationContent: { member in
                        MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(member.latitude) ?? 0.0, longitude: Double(member.longitude) ?? 0.0), tint: .red)
                    }
                )
                ScrollView{
                    ForEach($members, id: \.username) { member in
                        GroupMemberView(userName: member.username, profileImage: member.profileImage, latitude: member.latitude, longitude: member.longitude)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else{
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            print(String(describing: locationManager.region.span))
            vm.getIndividualGroup(id: groupId! )
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                groupData = vm.individualGroup
                members = vm.groupMembers
                shouldSHow.toggle()
                if let userLocation = locationManager.location {
                    mapRegion.center = userLocation
                    print(mapRegion.center)
                }
            }
        }
    }
}

struct IndividualGroupView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualGroupView(groupId: .constant("W7Jz2hHrx2MNnf8vD3AQ"))
    }
}
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

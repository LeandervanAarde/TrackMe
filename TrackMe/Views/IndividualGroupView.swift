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
    @State var groupData: GroupsModel?
    @State var shouldSHow: Bool = false
    @State var members: [personModel] = []
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        VStack{
            if(shouldSHow){
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
                .navigationTitle(groupData?.GroupName ?? "CHeck again")
                .frame(maxHeight: 300 )
                
                VStack{
                    List{
                        ForEach(0..<members.count){index in
                            Text(members[index].username)
                        }
                    }
                }
         
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else{
                ProgressView()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            vm.getIndividualGroup(id: groupId! )
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                groupData = vm.individualGroup
                members = vm.groupMembers
                shouldSHow.toggle()
                print(String(describing: shouldSHow))
            }
        }
    }
}

//struct IndividualGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualGroupView(groupId: "W7Jz2hHrx2MNnf8vD3AQ")
//    }
//}
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

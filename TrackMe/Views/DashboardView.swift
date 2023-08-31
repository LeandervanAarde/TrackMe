//
//  DashboardView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 01/08/2023.
//

import SwiftUI
import Charts
import Combine
import MapKit

struct DashboardView: View {
    let passthroughSubject = PassthroughSubject<Bool, Never>()
    @StateObject var healthKitManager = HealthKitManager()
    @ObservedObject var viewModel: AuthenticationViewModel = AuthenticationViewModel()
    @ObservedObject var userVm: UsersViewModel = UsersViewModel()
    @State var stepsData: [StepsModel] = []
    var body: some View {
        @State var showChart = true
        @State var displayReady = true
        
        if(displayReady){
            VStack {
                VStack {
                    HStack{
                        Text("Hello")
                            .foregroundColor(Color.black)
                            .font(.largeTitle)
                        Text(" \(userVm.userDetails?.username ?? "")👋")
                            .foregroundColor(Color.black)
                            .font(.largeTitle)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                    }
                    .padding(10)
                    
                    VStack{
                        Text("WANT TO SEE YOUR NEARBY USERS?")
                            .padding(.leading, 70)
                            .font(.subheadline)
                            .foregroundColor(Color("purple"))
                        Divider()
                            .frame(minHeight: 1)
                            .overlay(Color("Green"))
                            .padding(.leading, 70)
                        
                        Text("WANT TO SEE CONNETIONS MADE?")
                            .font(.subheadline)
                            .padding(.leading, 70)
                            .foregroundColor(Color("Green"))
                    }
                    .padding(.vertical, 3)
                    VStack {
                        
                        VStack{
                            Text("Distance walked today:")
                                .font(.subheadline)
                                .foregroundColor(Color("Green"))
                            
                            Spacer()
                                .frame(height: 10)
                            HStack {
                                VStack {
                                    
                                    if let lastSteps = stepsData.last?.steps {
                                        let distanceInKm = Double(lastSteps) / 1000.0
                                        Text("\(String(format: "%.2f", distanceInKm))")
                                            .font(.title2)
                                    } else{
                                        Text("No Data available")
                                            .font(.title2)
                                    }
                                    
                                    Divider()
                                        .frame(minHeight: 1)
                                        .background(Color("Green"))
                                        .padding(.horizontal)
                                }
                                
                                Text("Kilometeres")
                                    .font(.title2)
                            }
                        }
                
                        Spacer()
                            .frame(height: 20)
                        Spacer()
                        Text("Distance walked:")
                            .padding(.bottom, 5)
                        Chart {
                            ForEach(stepsData, id: \.id) { item in
                                BarMark(
                                    x: .value("day", item.day),
                                    y: .value("steps", item.steps)
                                )
                            }
                        }
                        .frame(maxHeight: 250)
                    }
                    .padding(20)
                }
                .frame(maxWidth: .infinity, maxHeight: 900, alignment: .top)
                .padding(20)
                .background(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            .background(Color("Green"))
            .onAppear{
                stepsData = healthKitManager.weeklySteps
            }
        } else{
            Text("Loading...")
        }
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}


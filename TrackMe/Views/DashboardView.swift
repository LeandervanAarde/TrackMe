//
//  DashboardView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 01/08/2023.
//

import SwiftUI
import Charts

struct DashboardView: View {
    var body: some View {
        let chartData = [
            (day: "Mon", connections: 10),
            (day: "Tue", connections: 1),
            (day: "Wed", connections: 3),
            (day: "Thu", connections: 1),
            (day: "Fri", connections: 0),
            (day: "Sat", connections: 1),
        ]
        
        VStack {
            Image("DashImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 230, alignment: .topLeading)
                .aspectRatio(contentMode: .fit)
            
        

            VStack {
                
                HStack{
                    Text("Hello")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                    Text("Leander")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                }
                .padding(20)
                
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
                
                VStack {
                    
                    Text("Connections made:")
                    Spacer()
                        .frame(height: 20)
                    Chart {
                        ForEach(chartData, id: \.day) { item in
                            LineMark(
                                x: .value("date", item.day),
                                y: .value("connections", item.connections)
                            )
                        }
                    }
                    .frame(maxHeight: 150)
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Distance Walked today:")
                        .foregroundColor(Color("Green"))
                    
                    
                        Text("5.14 Km")
                            .font(.body)
                            .fontWeight(.light)
                            .frame(maxWidth: .infinity)
                            .frame(alignment: .bottomLeading)
                            .foregroundColor(Color("Green"))
                    
                   
                    
                }
                .padding(20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 900, alignment: .top)
            .padding(20)
            .background(Color.white)
            .cornerRadius(radius: 170.0, corners: [.topLeft])
          
  

          

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .ignoresSafeArea()
        .background(Color("Green"))

    }
}

struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

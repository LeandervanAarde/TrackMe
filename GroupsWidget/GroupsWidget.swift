//
//  GroupsWidget.swift
//  GroupsWidget
//
//  Created by Leander Van Aarde on 01/09/2023.
//

import WidgetKit
import SwiftUI
import Intents

//MARK: - Provider where refresh on widget happends.
struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: [ GroupsModel(id: "1", GroupName: "Yakuza", GroupMembers: ["Hey", "No way"], GroupImage: "Festivals", GroupCode: "Hell yea brother")])
    }
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, data: [GroupsModel(id: "1", GroupName: "Yakuza", GroupMembers: ["Hey", "No way"], GroupImage: "Festivals", GroupCode: "Hell yea brother")])
        completion(entry)
    }

    //This is where I receive my daata
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        //getthe data and decode it
        print("Timeline started")
        
        Task{
            var decodedList = [GroupsModel]()
            
            if let encodedData = UserDefaults(suiteName: "group.LeandervanAarde.TrackMe")!.object( forKey: "groups"){
                
                let data = try? JSONDecoder().decode([GroupsModel].self, from: encodedData as! Data)
                
                decodedList = data ?? [GroupsModel(id: "1", GroupName: "n/a", GroupImage: "nul", GroupCode: "00000")]
            }
            print(decodedList.count)
            
            let entry = SimpleEntry(date: Date(), configuration: configuration, data: decodedList)
            
            let nextUpdate = Calendar.current.date(byAdding: DateComponents(minute: 1), to: Date())!
            
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let data: [GroupsModel] //Each entry I want to know what groups Im in 
}

struct GroupsWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    var tester = ["hey", "How", "Are"]
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
                
            VStack{
                Image("widget")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                HStack{                
                    Text(" Groups: \(entry.data.count)")
                        .font(.headline)
                        .fontWeight(.bold)
            
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: Color("Green"), location: 0.1),
                    Gradient.Stop(color: .black, location: 1.6),
                ]), startPoint: .top, endPoint: .bottom)
            )

        case .systemMedium:
                ForEach(entry.data){item in
                    VStack{
                        HStack{
                            Image(item.GroupImage)
                                .resizable()
                                .scaledToFit()
                                .frame( width: 40,height: 40)
                            Spacer()
                                
                            Text(item.GroupName)
                                .font(.title3)
                                .foregroundColor(Color("Green"))
                                .foregroundColor(.black)
                            
                            Spacer()
                            VStack{
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.gray)
                                
                                Text("\(item.GroupMembers?.count ?? 0)")
                                    .font(.body)
                                    .foregroundColor(Color("Green"))
                                    .foregroundColor(.black)
                                
                            }
                        }
                        Divider()
                    }
                    .padding(.horizontal)

                }

        default:
            ForEach(entry.data){item in
                Text(item.GroupName)
            }
        }
    
    }
}
// MARK: - Config where our view and provider meets.
struct GroupsWidget: Widget {
    let kind: String = "GroupsWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            GroupsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct GroupsWidget_Previews: PreviewProvider {
    static var previews: some View {
        GroupsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: [GroupsModel(id: "1", GroupName: "Yakuza", GroupMembers: ["Hey", "No way"], GroupImage: "Festivals", GroupCode: "Hell yea brother")]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

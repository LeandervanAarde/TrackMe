//
//  HealthKitManager.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 06/08/2023.
//
import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    let healthStore: HKHealthStore = HKHealthStore()
    let steps = HKQuantityType(.stepCount)
    @Published var weeklySteps: [StepsModel] = []
    
    init(){
        if(HKHealthStore.isHealthDataAvailable()){
            
            let heartBeat = HKQuantityType(.heartRate)
            let healtTyoes: Set = [steps, heartBeat]
            
            Task{
                do{
                    try await healthStore.requestAuthorization(toShare: [], read: healtTyoes)
                    fetchSteps()
                }catch{
                    print("Error retreving data")
                }
            }
        }
    }
    
    func fetchSteps() {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        let today = Date()
        let startOfWeek = Calendar.firstWeekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
            
        guard let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek) else {
                print("Failed to calculate the end date of the week.")
                return
            }
            
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfWeek,
            end: endOfWeek,
            options: .strictStartDate
        )
            
        let query = HKStatisticsCollectionQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum,
            anchorDate: startOfWeek,
            intervalComponents: DateComponents(day: 1)
            )
    
        query.initialResultsHandler = { _, result, error in
            guard let result = result, error == nil else {
                print("Error getting steps \(error?.localizedDescription ?? "")")
                return
            }

        result.enumerateStatistics(from: startOfWeek, to: today) { statistics, _ in
            if let quantity = statistics.sumQuantity() {
                let steps = Int(quantity.doubleValue(for: HKUnit.count()))
                let date = statistics.startDate
                let dayOfWeek = dateFormatter.string(from: date)
                self.weeklySteps.append(StepsModel(day: dayOfWeek, steps: steps))
                    print("\(dayOfWeek) - \(steps)")
                }
            }
        }
        healthStore.execute(query)
    }
}

extension Calendar {
    static var firstWeekday: Date {
        let calendar = Calendar.current
        let now = Date()
        let beginningOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.start
        return beginningOfWeek ?? now
    }
}

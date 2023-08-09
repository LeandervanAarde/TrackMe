//
//  StepsModel.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 08/08/2023.
//

import Foundation

struct StepsModel: Identifiable, Codable, Equatable {
    var id = UUID()
    var day: String
    var steps: Int
}

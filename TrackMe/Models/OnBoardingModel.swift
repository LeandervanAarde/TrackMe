//
//  OnBoardingModel.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 02/08/2023.
//

import Foundation

struct OnBoardingModel: Identifiable, Codable {
    var id: Int
    var imageSource: String
    var heading: String
    var content: String
}

//
//  GroupsWidgetBundle.swift
//  GroupsWidget
//
//  Created by Leander Van Aarde on 01/09/2023.
//

import WidgetKit
import SwiftUI

@main
struct GroupsWidgetBundle: WidgetBundle {
    var body: some Widget {
        GroupsWidget()
        GroupsWidgetLiveActivity()
    }
}

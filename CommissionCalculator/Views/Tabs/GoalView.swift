//
//  GoalView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct GoalView: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    PayoutSection(monthData: monthData, profile: profile)
                    MultiplierSchedule(monthData: monthData, profile: profile)
                    AttainmentSection(monthData: monthData, profile: profile)
                }
            }
            .navigationTitle("Goals")
        }
    }
}


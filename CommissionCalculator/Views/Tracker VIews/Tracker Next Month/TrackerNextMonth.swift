//
//  TrackerNextMonth.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift


struct TrackerNextMonth: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    var body: some View {
        Section(content: {
            NavigationLink(destination: {
                NextMonthDetail(monthData: monthData, profile: profile)
            }, label: {
                NextMonthOverview(monthData: monthData)
            })
        }, header: {
            Text("Sales For Next Month")
                .foregroundColor(.secondary)
        })
    }
}

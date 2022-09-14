//
//  TrackerPriorMonth.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct TrackerPriorMonth: View {
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        Section(content: {
            NavigationLink(destination: {
                PriorMonthDetail(monthData: monthData)
            }, label: {
                PriorMonthOverview(monthData: monthData)
            })
        }, header: {
            Text("Sales From Last Month")
                .foregroundColor(.secondary)
        })
    }
}


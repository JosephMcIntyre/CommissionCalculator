//
//  TrackerView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct TrackerView: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    @State private var isPriorOrder = false
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    TrackerCurrMonth(monthData: monthData)
                    TrackerPriorMonth(monthData: monthData)
                    TrackerNextMonth(monthData: monthData, profile: profile)
                    TrackerChargebacks(monthData: monthData)
                }
                AddOrderFloatButton(monthData: monthData, currSellingDay: $profile.currSellingDay, payoutStatus: PayoutStatus.Pending, isPriorOrder: $isPriorOrder)
            }
            .navigationTitle("Tracker")
        }
    }
}

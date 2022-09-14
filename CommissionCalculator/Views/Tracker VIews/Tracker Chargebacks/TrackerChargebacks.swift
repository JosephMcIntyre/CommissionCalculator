//
//  TrackerChargebacks.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift


struct TrackerChargebacks: View {
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        Section(content: {
            NavigationLink(destination: {
                TrackerChargebacksEditor(monthData: monthData)
            }, label: {
                ChargebacksOverview(monthData: monthData)
            })
        }, header: {
            Text("Chargebacks")
                .foregroundColor(.secondary)
        })
    }
}

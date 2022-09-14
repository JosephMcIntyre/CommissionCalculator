//
//  NextMonthOverview.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift


struct NextMonthOverview: View {
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text("Sales Rev: ") + Text("$\(monthData.CalcMonthPayout(status: PayoutStatus.NextMonth), specifier: "%.2f")").foregroundColor(.yellow)
            Spacer()
            Text("Orders: ")
            Text("\(monthData.CalcMonthOrderCount(status: PayoutStatus.NextMonth))")
                .foregroundColor(.secondary)
        }
    }
}

//
//  PriorMonthOverview.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct PriorMonthOverview: View {
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text("Sales Rev: ") + Text("$\(monthData.CalcPriorMonthPayout(), specifier: "%.2f")").foregroundColor(.green)
            Spacer()
            Text("Orders: ")
            Text("\(monthData.CalcPriorMonthOrderCount())")
                .foregroundColor(.secondary)
        }
    }
}

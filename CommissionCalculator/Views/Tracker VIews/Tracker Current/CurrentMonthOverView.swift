//
//  CurrentMonthOverView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct CurrentMonthOverView: View {
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text("Sales Rev: ") + Text("$\(monthData.CalcMonthPayout(status: PayoutStatus.Pending) + monthData.CalcMonthPayout(status: PayoutStatus.Paid) + monthData.CalcMonthPayout(status: PayoutStatus.Backordered), specifier: "%.2f")").foregroundColor(.green)
            Spacer()
            Text("Orders: ")
            Text("\(monthData.CalcMonthOrderCount(status: PayoutStatus.Pending) + monthData.CalcMonthOrderCount(status: PayoutStatus.Paid) + monthData.CalcMonthOrderCount(status: PayoutStatus.Backordered) + monthData.CalcMonthOrderCount(status: PayoutStatus.Cancelled))")
                .foregroundColor(.secondary)
        }
    }
}

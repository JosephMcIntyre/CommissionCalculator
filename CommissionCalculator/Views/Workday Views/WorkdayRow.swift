//
//  WorkdayRow.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct WorkdayRow: View {
    @State var sellingDay: Int
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        NavigationLink(destination: {
            WorkdayView(sellingDay: $sellingDay, monthData: monthData)
        }, label: {
            HStack {
                Image(systemName: "\(sellingDay).circle.fill")
                    .rowSymbolModifier()
                    .foregroundColor(.secondary)
                Text("Sales Rev: $\(monthData.CalcWorkDayPayout(workDay: sellingDay, status: PayoutStatus.Paid) + monthData.CalcWorkDayPayout(workDay: sellingDay, status: PayoutStatus.Pending) + monthData.CalcWorkDayPayout(workDay: sellingDay, status: PayoutStatus.Backordered), specifier:  "%.2f")")
                Spacer()
                Text("Orders: ")
                Text("\(monthData.CalcWorkdayOrderCount(workDay: sellingDay, status: PayoutStatus.Paid) + monthData.CalcWorkdayOrderCount(workDay: sellingDay, status: PayoutStatus.Pending) + monthData.CalcWorkdayOrderCount(workDay: sellingDay, status: PayoutStatus.Backordered))")
                    .foregroundColor(.secondary)
            }
        })
    }
}


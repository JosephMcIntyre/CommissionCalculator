//
//  ChargebacksOverview.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift


struct ChargebacksOverview: View {
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text("Sales Rev: ") + Text("-$\(monthData.UnitsPayoutCalc(), specifier: "%.2f")").foregroundColor(.red)
            Spacer()
        }
    }
}

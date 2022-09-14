//
//  OrderRow.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct OrderRow: View {
    @ObservedRealmObject var order: Order
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Order: \(order.number)")
                HStack {
                    if order.payoutStatus == PayoutStatus.Paid {
                        Text("\(order.payoutStatus.description)")
                            .foregroundColor(.green)
                    } else if order.payoutStatus == PayoutStatus.Cancelled {
                        Text("\(order.payoutStatus.description)")
                            .foregroundColor(.red)
                    } else {
                        Text("\(order.status.description) & \(order.payoutStatus.description)")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("$\(order.UnitsPayoutCalc(),  specifier: "%.2f")")
                        .foregroundColor(.green)
                }
                OrderRowSymbols(order: order)
            }
        }
    }
}


struct OrderRowSymbols: View {
    @ObservedRealmObject var order: Order
    var body: some View {
        HStack {
            if order.pga > 0{
                Image(systemName: "iphone")
                    .rowSymbolModifier()
            }
            if order.renew > 0 {
                Image(systemName: "candybarphone")
                    .rowSymbolModifier()
            }
            
            if order.premUNL > 0 {
                Image(systemName: "infinity")
                    .rowSymbolModifier()
            }
            if order.fwa > 0 {
                Image(systemName: "wifi.router")
                    .rowSymbolModifier()
            }
            if order.tablet > 0 {
                Image(systemName: "ipad.rear.camera")
                    .rowSymbolModifier()
            }
            if order.jetpack > 0 {
                Image(systemName: "externaldrive")
                    .rowSymbolModifier()
            }
            if order.connDevice > 0 {
                Image(systemName: "applewatch")
                    .rowSymbolModifier()
            }
            if order.features > 0 {
                Image(systemName: "lock.shield")
                    .rowSymbolModifier()
            }
            if order.ard > 0 {
                Image(systemName: "earbuds")
                    .rowSymbolModifier()
            }
        }
    }
}



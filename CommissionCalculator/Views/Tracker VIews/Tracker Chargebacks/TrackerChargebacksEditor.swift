//
//  TrackerChargebacksEditor.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift


struct TrackerChargebacksEditor: View {
    @Environment(\.realm) var realm
    @ObservedRealmObject var monthData: MonthData
    var body: some View {
        NavigationStack {
            List {
                ChargebackUnitView(title: "PGA", symbol: "iphone", unit: $monthData.pga)
                ChargebackUnitView(title: "Renew", symbol: "candybarphone", unit: $monthData.renew)
                ChargebackUnitView(title: "PremUNL", symbol: "infinity", unit: $monthData.premUNL)
                ChargebackUnitView(title: "FWA", symbol: "wifi.router", unit: $monthData.fwa)
                ChargebackUnitView(title: "Tablet", symbol: "ipad.rear.camera", unit: $monthData.tablet)
                ChargebackUnitView(title: "Jetpack", symbol: "externaldrive", unit: $monthData.jetpack)
                ChargebackUnitView(title: "Conn Device", symbol: "applewatch", unit: $monthData.connDevice)
            }
            .navigationTitle("Chargebacks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(role: .destructive) {
                            try? realm.write {
                                monthData.thaw()?.pga = 0
                                monthData.thaw()?.renew = 0
                                monthData.thaw()?.premUNL = 0
                                monthData.thaw()?.fwa = 0
                                monthData.thaw()?.tablet = 0
                                monthData.thaw()?.jetpack = 0
                                monthData.thaw()?.connDevice = 0
                                monthData.thaw()?.features = 0
                                monthData.thaw()?.ard = 0
                            }
                            
                        } label: { Label("Reset Chargebacks", systemImage: "trash") }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}

struct ChargebackUnitView: View {
    @State var title: String
    @State var symbol: String
    @Binding var unit: Int
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text(title)
            Spacer()
            Button {
                unit += 1
            } label: {
                Image(systemName: "plus.circle.fill")
                    .rowSymbolModifier()
                    .foregroundColor(.red)
            }.buttonStyle(.plain)
            Button {
                unit -= 1
            } label: {
                Image(systemName: "minus.circle.fill")
                    .rowSymbolModifier()
                    .foregroundColor(.blue)
                    .opacity(unit == 0 ? 0.5 : 1.0)
            }.buttonStyle(.plain).disabled(unit == 0)
            .padding(.trailing, 5)
            Text("\(unit)")
                .foregroundColor(.red)
        }
    }
}

struct ChargebackUnitView2: View {
    @State var title: String
    @State var symbol: String
    @Binding var unit: Double
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text(title)
            Spacer()
            TextField("0", value: $unit, formatter: currencyFormatter)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .foregroundColor(.red)
            
        }
    }
}

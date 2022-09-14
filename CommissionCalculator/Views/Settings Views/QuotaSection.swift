//
//  QuotaSection.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct QuotaSection: View {
    @ObservedRealmObject var profile: Profile

    @State private var title = "Quota"
    @State private var isCollapsed = false
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    func calcSalesRelief() -> Double {
        let percentOff = (profile.empStatus.hoursMonth-(profile.pto*8)) / profile.empStatus.hoursMonth
        var reliefSalesRev = profile.salesRev
        if profile.ptoException == true || profile.pto >= 3 {
            reliefSalesRev *= percentOff
        }
        return reliefSalesRev
    }
    func calcNewRelief() -> Double {
        let percentOff = (profile.empStatus.hoursMonth-profile.pto) / profile.empStatus.hoursMonth
        var reliefNewRev = profile.newRev
        if profile.ptoException == true || profile.pto >= 3 {
            reliefNewRev *= percentOff
        }
        return reliefNewRev
    }
    
    var body: some View {
        Section(content: {
            if isCollapsed == false {
                Grid() {
                    GridRow {
                        Text("")
                        Text("Sales Rev").foregroundColor(.secondary)
                        Text("PGA & FWA").foregroundColor(.secondary)
                    }
                    GridRow {
                        Text("Target").foregroundColor(.secondary)
                        TextField("0", value: $profile.salesRev, formatter: currencyFormatter)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numbersAndPunctuation)
                            .foregroundColor(.blue)
                        TextField("0", value: $profile.newRev, formatter: currencyFormatter)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numbersAndPunctuation)
                        
                    }.padding(.vertical)
                    GridRow {
                        Text("Adjusted").foregroundColor(.secondary)
                        Text("$\(calcSalesRelief(), specifier: "%.2f")")
                        Text("$\(calcNewRelief(),  specifier: "%.2f")")
                    }
                }
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}

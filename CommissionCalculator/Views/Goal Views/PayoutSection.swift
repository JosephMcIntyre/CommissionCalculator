//
//  PayoutSection.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct PayoutSection: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    
    @State private var title = "Commission"
    @State private var isCollapsed = false
    
    
    func CalcCommission() -> Double {
        if CalcPercentage() < 50 {
            return 0.00
        } else {
            let commission = CalcPercentage() * profile.empStatus.atRisk / 100
             if CalcNewPercentage() < 90 && commission > profile.empStatus.atRisk {
                return profile.empStatus.atRisk
            } else {
                return commission
            }
        }
    }
    
    func CalcPercentage() -> Double {
        let quota = profile.calcSalesRelief()
        if quota > 0 {
            let percentage = monthData.CalcMonthSalesRev() / profile.calcSalesRelief() * 100
            return percentage
        } else {
            return 0.00
        }
    }
    func CalcNewPercentage() -> Double {
        let quota = profile.calcNewRelief()
        if quota > 0 {
            let percentage = monthData.CalcMonthNewsRev() / profile.calcNewRelief() * 100
            return percentage
        } else {
            return 0.00
        }
    }
    
    var body: some View {
        Section(content: {
            if isCollapsed == false {
                HStack {
                    Text("Attainment")
                    Spacer()
                    Text("$\(monthData.CalcTotalRevSold(), specifier:  "%.2f")")
                        .foregroundColor(monthData.CalcMonthSalesRev() >= profile.calcSalesRelief() ? .green : .secondary)
                }
                HStack {
                    Text("Percentage")
                    Spacer()
                    Text("\(CalcPercentage(),  specifier:  "%.0f")%")
                        .foregroundColor(CalcPercentage() >= 100.00 ? .green : .secondary)
                }
                HStack {
                    Text("At-Risk")
                    Spacer()
                    Text("$\(profile.empStatus.atRisk, specifier:  "%.0f")")
                        .foregroundColor(.secondary)
                }
            }
            HStack {
                Text("Check")
                Spacer()
                Text("$\(CalcCommission(),  specifier:  "%.2f")")
                    .foregroundColor(CalcCommission() >= Double(profile.empStatus.atRisk) ? .green : .secondary)
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}

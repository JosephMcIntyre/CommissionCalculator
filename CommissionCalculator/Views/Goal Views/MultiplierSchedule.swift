//
//  MultiplierAttainment.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct MultiplierSchedule: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    @State private var percentages: [Double] = [ 50, 100, 150, 200, 250, 300]
    @State private var title = "Multiplier Schedule"
    @State private var isCollapsed = false
    var body: some View {
        Section(content: {
            if isCollapsed == false {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sales Rev")
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        Text("90% New")
                        Text("50%")
                        Text("100%")
                        Text("150%")
                        Text("200%")
                        Text("250%")
                        Text("300%")
                    }
                    Spacer()
                    MultiplierNeedCol(monthData: monthData, profile: profile, percentages: $percentages)
                    Spacer()
                    MultiplierToGoCol(monthData: monthData, profile: profile, percentages: $percentages)
                    Spacer()
                    MultiplierDailyCol(monthData: monthData, profile: profile, percentages: $percentages)
                }
                .font(.callout)
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}

struct MultiplierNeedCol: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    @Binding var percentages: [Double]
    
    func CalcSalesRevNeeded(percentage: Double) -> Double {
        let revNeeded = Double(percentage) * profile.calcSalesRelief() / 100
        return revNeeded
    }
    func CalcNewRevNeeded(percentage: Double) -> Double {
        let revNeeded = Double(percentage) * profile.calcNewRelief() / 100
        return revNeeded
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Need")
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Text("$\(CalcNewRevNeeded(percentage: 90), specifier:  "%.0f")").foregroundColor(.secondary)
            ForEach(percentages, id: \.self) { percentage in
                Text("$\(CalcSalesRevNeeded(percentage: percentage), specifier:  "%.0f")")
            }.foregroundColor(.secondary)
            
            
        }
    }
}

struct MultiplierToGoCol: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    @Binding var percentages: [Double]
    
    func CalcSalesRevToGo(percentage: Double) -> Double {
        let revNeeded = Double(percentage) * profile.calcSalesRelief() / 100  - monthData.CalcTotalRevSold()
        if revNeeded > 0 {
            return revNeeded
        } else {
            return 0
        }
    }
    func CalcNewRevToGo(percentage: Double) -> Double {
        let revNeeded = Double(percentage) * profile.calcNewRelief() / 100  - monthData.CalcTotalRevSold()
        if revNeeded > 0 {
            return revNeeded
        } else {
            return 0
        }
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Remaining")
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Text("$\(CalcNewRevToGo(percentage: 90), specifier:  "%.0f")").foregroundColor(.secondary)
            ForEach(percentages, id: \.self) { percentage in
                Text("$\(CalcSalesRevToGo(percentage: percentage), specifier:  "%.0f")")
            }.foregroundColor(.secondary)
        }
    }
}

struct MultiplierDailyCol: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    @Binding var percentages: [Double]
    
    func CalcSalesDailyo(percentage: Double) -> Double {
        let revNeeded = Double(percentage) * profile.calcSalesRelief() / 100  - monthData.CalcTotalRevSold()
        let dailyRev = revNeeded / Double(profile.totalSellingDays - profile.currSellingDay + 1)
        if dailyRev > 0 {
            return dailyRev
        } else {
            return 0
        }
    }
    func CalcNewRevDaily(percentage: Double) -> Double {
        let revNeeded = Double(percentage) * profile.calcNewRelief() / 100  - monthData.CalcTotalRevSold()
        let dailyRev = revNeeded / Double(profile.totalSellingDays - profile.currSellingDay + 1)
        if dailyRev > 0 {
            return dailyRev
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Daily")
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Text("$\(CalcNewRevDaily(percentage: 90), specifier:  "%.0f")").foregroundColor(.secondary)
            ForEach(percentages, id: \.self) { percentage in
                Text("$\(CalcSalesDailyo(percentage: percentage), specifier:  "%.0f")")
            }.foregroundColor(.secondary)
        }
    }
}



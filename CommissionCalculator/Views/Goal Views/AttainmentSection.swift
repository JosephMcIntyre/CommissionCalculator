//
//  AttainmentSection.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct AttainmentSection: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    
    @State private var title = "Attainment"
    @State private var isCollapsed = false
    
    var body: some View {
        Section(content: {
            if isCollapsed == false {
                HStack(alignment: .top) {
                    AttainmentLabels().padding(.trailing, 5)
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            
                            AttainmentSummaryRevenue(monthData: monthData, title: "Rev").padding(.trailing, 5)
                            AttainmentSummary(monthData: monthData, title: "Total").padding(.trailing, 5)
                            AttainmentColumn(monthData: monthData, payoutStatus: PayoutStatus.Paid, title: "Paid").padding(.trailing, 5)
                            AttainmentColumn(monthData: monthData, payoutStatus: PayoutStatus.Pending, title: "Pending").padding(.trailing, 5)
                            AttainmentColumn(monthData: monthData, payoutStatus: PayoutStatus.Backordered, title: "Backordered").padding(.trailing, 5)
                            AttainmentPriorMonthSales(monthData: monthData, title: "Prior Month").padding(.trailing, 5)
                            AttainmentChargeBacks(monthData: monthData, title: "Chargebacks")
                            AttainmentSpacing()
                        }
                    }
                }
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}

struct AttainmentLabels: View {
    @State private var titles = [
        "PGA",
        "Renew",
        "PremUNL",
        "FWA",
        "Tab/Jet",
        "Conn",
        "Feat",
        "ARD",
        "15% ARD",
        "Total"
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("spacing").foregroundColor(.clear).fontWeight(.bold)
            ForEach(titles, id: \.self) { title in
                Text(title)
            }
        }.fontWeight(.bold)
    }
}

struct AttainmentSummary: View {
    @ObservedRealmObject var monthData: MonthData
    @State var title: String
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(title)
                .fontWeight(.bold)
            ForEach(0...5, id: \.self) { unit in
                Text("\(monthData.CountTotalUnits()[unit], specifier: "%.0f")")
            }.foregroundColor(.secondary)
            ForEach(6...8, id: \.self) { unit in
                Text("$\(monthData.CountTotalUnits()[unit], specifier: "%.2f")")
            }.foregroundColor(.secondary)
            Text("spacing").foregroundColor(.clear)
        }
    }
}

struct AttainmentSummaryRevenue: View {
    @ObservedRealmObject var monthData: MonthData
    @State var title: String
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text(title)
                .fontWeight(.bold)
            ForEach(0...5, id: \.self) { unit in
                Text("$\(monthData.CountTotalUnits()[unit] * 100, specifier: "%.0f")")
            }.foregroundColor(.secondary)
            ForEach(6...8, id: \.self) { unit in
                Text("$\(monthData.CountTotalUnits()[unit], specifier: "%.2f")")
            }.foregroundColor(.secondary)
            Text("$\(monthData.CalcTotalRevSold(), specifier: "%.2f")")
                .foregroundColor(monthData.CalcTotalRevSold() < 0 ? .red : .green)
        }
    }
}


struct AttainmentColumn: View {
    @ObservedRealmObject var monthData: MonthData
    @State var payoutStatus: PayoutStatus
    @State var title: String
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text(title)
                .fontWeight(.bold)
            ForEach(0...5, id: \.self) { unit in
                Text("\(monthData.CountOrderUnits(status: payoutStatus)[unit], specifier: "%.0f")")
            }.foregroundColor(.secondary)
            ForEach(6...7, id: \.self) { unit in
                Text("$\(monthData.CountOrderUnits(status: payoutStatus)[unit], specifier: "%.2f")")
            }.foregroundColor(.secondary)
        }
    }
}


struct AttainmentPriorMonthSales: View {
    @ObservedRealmObject var monthData: MonthData
    @State var title: String
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text(title)
                .fontWeight(.bold)
            ForEach(0...5, id: \.self) { unit in
                Text("\(monthData.CountPriorMonthUnits()[unit], specifier: "%.0f")")
            }.foregroundColor(.secondary)
            ForEach(6...7, id: \.self) { unit in
                Text("$\(monthData.CountPriorMonthUnits()[unit], specifier: "%.2f")")
            }.foregroundColor(.secondary)
        }
    }
}

struct AttainmentChargeBacks: View {
    @ObservedRealmObject var monthData: MonthData
    @State var title: String
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text(title)
                .fontWeight(.bold)
            Text("\(monthData.pga, specifier: "%.0f")")
            Text("\(monthData.renew, specifier: "%.0f")")
            Text("\(monthData.premUNL, specifier: "%.0f")")
            Text("\(monthData.fwa, specifier: "%.0f")")
            Text("\(monthData.jetpack + monthData.tablet, specifier: "%.0f")")
            Text("\(monthData.connDevice, specifier: "%.0f")")
        }.foregroundColor(.red)
    }
}

struct AttainmentSpacing: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Spacing")
                .fontWeight(.bold)
            ForEach(0...8, id: \.self) { unit in
                Text("Spacing")
            }
        }.foregroundColor(.clear)
    }
}

//
//  TrackerCurrMonth.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct TrackerCurrMonth: View {
    @ObservedRealmObject var monthData: MonthData
    @State private var isCollapsed = true
    @State private var title = "Current Month"
    
    var body: some View {
        Section(content: {
        
            if isCollapsed == false {
                ForEach(1..<32, id: \.self) { sellingDay in
                    WorkdayRow(sellingDay: sellingDay, monthData: monthData)
                }
            } else {
                NavigationLink(destination: {
                    CurrentMonthDetail(monthData: monthData)
                }, label: {
                    CurrentMonthOverView(monthData: monthData)
                })
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}



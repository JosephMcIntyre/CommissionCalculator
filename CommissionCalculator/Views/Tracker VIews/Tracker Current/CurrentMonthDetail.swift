//
//  CurrentMonthDetail.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct CurrentMonthDetail: View {
    @ObservedRealmObject var monthData: MonthData
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(1..<32, id: \.self) { sellingDay in
                    WorkdayRow(sellingDay: sellingDay, monthData: monthData)
                }
            }
            .navigationTitle("Current Month")
        }
    }
}


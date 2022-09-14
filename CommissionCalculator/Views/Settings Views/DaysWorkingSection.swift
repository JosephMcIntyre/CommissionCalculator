//
//  DaysWorkingSection.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct DaysWorkingSection: View {
    @ObservedRealmObject var profile: Profile
    
    @State private var title = "Days Working"
    @State private var isCollapsed = false
    
    let decimalformatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
        
    var body: some View {
        Section(content: {
            if isCollapsed == false {
                Menu {
                    Picker("", selection: $profile.currSellingDay) {
                        ForEach(1..<32, id: \.self) {
                        Text("Day \($0)")
                        }
                    }
                } label: {
                    HStack {
                        RowLabel(title: "CurrentDay", symbol: "star")
                        Spacer()
                        Text("\(profile.currSellingDay)")
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
                Menu {
                    Picker("", selection: $profile.totalSellingDays) {
                        ForEach((1...31).reversed(), id: \.self) {
                        Text("\($0) Days")
                        }
                    }
                } label: {
                    HStack {
                        RowLabel(title: "Total Working Days", symbol: "sum")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(profile.totalSellingDays)")
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
                HStack {
                    RowLabel(title: "Days Left", symbol: "timer")
                    Spacer()
                    Text("\(profile.totalSellingDays - profile.currSellingDay)")
                }
                HStack {
                    RowLabel(title: "PTO", symbol: "airplane")
                    Text("Enter in Days").foregroundColor(.secondary)
                    TextField("0", value: $profile.pto, formatter: decimalformatter)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numbersAndPunctuation)
                }
                Toggle(isOn: $profile.ptoException) {
                    RowLabel(title: "Exception", symbol: "building.columns")
                }
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}


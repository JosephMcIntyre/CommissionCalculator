//
//  ProfileSection.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct ProfileSection: View {
    @Binding var empStatus: EmpStatus
    
    @State private var title = "Profile"
    @State private var isCollapsed = false

    var body: some View {
        Section(content: {
            Menu {
                Picker("Status", selection: $empStatus) {
                    Text("\(EmpStatus.FT.description)").tag(EmpStatus.FT)
                    Text("\(EmpStatus.PT32.description)").tag(EmpStatus.PT32)
                    Text("\(EmpStatus.PT24.description)").tag(EmpStatus.PT24)
                }
            } label: {
                HStack {
                    RowLabel(title: "Status", symbol: "wrench.and.screwdriver")
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(empStatus.description)")
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
            }
            if isCollapsed == false {
                HStack {
                    RowLabel(title: "Average Hrs per Week", symbol: "calendar.day.timeline.leading")
                    Spacer()
                    Text("\(empStatus.hoursWeek)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    RowLabel(title: "Expected Monthly Hrs", symbol: "calendar")
                    Spacer()
                    Text("\(empStatus.hoursMonth, specifier: "%.1f")")
                        .foregroundColor(.secondary)
                }
                HStack {
                    RowLabel(title: "At Risk", symbol: "dollarsign")
                    Spacer()
                    Text("$\(empStatus.atRisk, specifier: "%.0f")")
                        .foregroundColor(.secondary)
                }
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}



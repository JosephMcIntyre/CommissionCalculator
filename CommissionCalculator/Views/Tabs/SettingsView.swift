//
//  SettingsView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct SettingsView: View {
    @Environment(\.realm) var realm
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile

    var body: some View {
        NavigationStack {
            List {
                QuotaSection(profile: profile)
                DaysWorkingSection(profile: profile)
                ProfileSection(empStatus: $profile.empStatus)
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Link(destination: URL(string: "https://github.com/josephmcintyre")!) {
                        Image(systemName: "questionmark.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(role: .destructive) {
                            try! realm.write {
                                realm.deleteAll()
                            }
                        } label: {
                            Label("Reset All Data", systemImage: "trash")
                        }
                    } label: { Image(systemName: "ellipsis.circle")}
                }
            }
        }
    }
}



//
//  ContentView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/13/22.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(Profile.self) var userProfile
    @ObservedResults(MonthData.self) var data
    
    var body: some View {
        if let profile = userProfile.first {
            if let monthData = data.first {
                TabView {
                    TodayView(monthData: monthData, profile: profile)
                        .tabItem { Label("Workday", systemImage: "star") }
                        .tag(0)
                    TrackerView(monthData: monthData, profile: profile)
                        .tabItem { Label("Tracker", systemImage: "calendar") }
                        .tag(1)
                    GoalView(monthData: monthData, profile: profile)
                        .tabItem { Label("Goals", systemImage: "dollarsign") }
                        .tag(2)
                    SettingsView(monthData: monthData, profile: profile)
                        .tabItem { Label("Settings", systemImage: "gear") }
                        .tag(3)
                }
            } else {
                OnboardingView().onAppear {
                
            }
            }
        } else {
            OnboardingView().onAppear {
                $userProfile.append(Profile())
                $data.append(MonthData())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

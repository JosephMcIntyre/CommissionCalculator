//
//  TodayView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift
struct TodayView: View {
    
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    @State private var isPriorOrder = false

    var body: some View {
        NavigationStack {
            ZStack {
                WorkdayDetail(sellingDay: $profile.currSellingDay, monthData: monthData).environment(\.editMode, $editMode)
                AddOrderFloatButton(monthData: monthData, currSellingDay: $profile.currSellingDay, payoutStatus: PayoutStatus.Pending, isPriorOrder: $isPriorOrder)
            }
            .navigationTitle("Workday \(profile.currSellingDay)")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if editMode == .inactive {
                        Menu {
                            Menu {
                                Picker("Change Workday", selection: $profile.currSellingDay) {
                                    ForEach(1..<32, id: \.self) {
                                        Text("Day \($0)")
                                    }
                                }
                            } label: {
                                Label("Change Workday", systemImage: "star")
                            }
                            Button(action: {
                                editMode = .active
                            }) {
                                Label("Edit Orders", systemImage: "pencil")
                            }
                            
                        } label: { Image(systemName: "ellipsis.circle")}
                    } else {
                        Button {
                            editMode = .inactive
                        } label: {
                            Text("Done")
                        }
                    }
                }
            }
        }
    }
    func delete(at offsets: IndexSet) {
        $monthData.orders.remove(atOffsets: offsets)
    }

}

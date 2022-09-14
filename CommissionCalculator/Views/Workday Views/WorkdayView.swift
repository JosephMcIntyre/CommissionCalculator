//
//  WorkdayView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct WorkdayView: View {
    @Binding var sellingDay: Int
    @State var editMode: EditMode = .inactive
    @ObservedRealmObject var monthData: MonthData
    @State private var isPriorOrder = false
    var body: some View {
        NavigationStack {
            ZStack {
                WorkdayDetail(sellingDay: $sellingDay, monthData: monthData).environment(\.editMode, $editMode)
                AddOrderFloatButton(monthData: monthData, currSellingDay: $sellingDay, payoutStatus: PayoutStatus.Pending, isPriorOrder: $isPriorOrder)
            }
            .navigationTitle("Workday \(sellingDay)")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if editMode == .inactive {
                        Menu {
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



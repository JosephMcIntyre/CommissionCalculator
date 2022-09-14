//
//  NextMonthDetail.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift


struct NextMonthDetail: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var profile: Profile
    @State var editMode: EditMode = .inactive
    @State private var isPriorOrder = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(monthData.orders.filter { $0.payoutStatus == PayoutStatus.NextMonth}, id: \.id ) { order in
                        NavigationLink(destination: {
                            OrderDetails(order: order, monthData: monthData)
                        }, label: {
                            OrderRow(order: order)
                        })
                    }
                    .onDelete(perform: delete)
                }.environment(\.editMode, $editMode)
                AddOrderFloatButton(monthData: monthData, currSellingDay: $profile.currSellingDay, payoutStatus: PayoutStatus.NextMonth, isPriorOrder: $isPriorOrder)
            }
            .navigationTitle("Next Month Orders")
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

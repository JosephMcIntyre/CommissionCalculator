//
//  PriorMonthDetail.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct PriorMonthDetail: View {
    @ObservedRealmObject var monthData: MonthData
    @State private var sellingDay = 0
    @State var editMode: EditMode = .inactive
    @State private var isPriorOrder = true
        
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(monthData.priorMonthOrders, id: \.id ) { order in
                        NavigationLink(destination: {
                            
                        }, label: {
                            OrderRow(order: order)
                            
                        })
                        
                    }
                    .onDelete(perform: delete)
                }.environment(\.editMode, $editMode)
                AddOrderFloatButton(monthData: monthData, currSellingDay: $sellingDay, payoutStatus: PayoutStatus.Backordered, isPriorOrder: $isPriorOrder)
            }
            .navigationTitle("Prior Month Orders")
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
        $monthData.priorMonthOrders.remove(atOffsets: offsets)
    }
}

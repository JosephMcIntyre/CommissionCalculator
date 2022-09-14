//
//  AddOrderRowButton.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct AddOrderRowButton: View {
    @ObservedRealmObject var monthData: MonthData
    @Binding var currSellingDay: Int
    @State var payoutStatus: PayoutStatus
    @Binding var isPriorOrder: Bool
    @State private var showAddOrderView = false
    @State private var newOrder = Order()
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "plus.circle.fill")
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text("Add Order")
            Spacer()
        }
    
    
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    newOrder = Order()
                    newOrder.sellingDay = currSellingDay
                    newOrder.payoutStatus = payoutStatus
                    showAddOrderView.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 48, height: 48)
                }
            }
        }.padding()
        .sheet(isPresented: $showAddOrderView) {
            AddOrderView(monthData: monthData, newOrder: newOrder, isPriorOrder: $isPriorOrder)
        }
    }
}

//
//  OrderDetails.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct OrderDetails: View {
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var order: Order
    @ObservedRealmObject var monthData: MonthData
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Group {
                        Text("Payout: ") +
                        Text("$\(order.UnitsPayoutCalc(), specifier:  "%.2f")").foregroundColor(.green)
                    }
                    Spacer()
                }.padding(.bottom, 10)
                List {
                    OrderInfoSection(order: order)
                    OrderUnitsSection(order: order)
                }
            }
            .navigationTitle("Order Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                    Menu {
                        Button(role: .destructive, action: {
                            if let index = monthData.orders.firstIndex(of: order) {
                                $monthData.orders.remove(at: index)
                            }
                            dismiss()
                        }) {
                            Label("Delete Order", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.blue)
                    }
                }
                
            }
        }
    }
}

struct OrderInfoSection: View {
    @Environment(\.realm) var realm
    @ObservedRealmObject var order: Order
    @State private var isCollapsed = false
    @State private var title = "Order Info"
    
    func UpdateStatuses() {
        if order.status == OrderStatus.Cancelled {
            try? realm.write {
                order.thaw()?.payoutStatus = PayoutStatus.Cancelled
            }
        } else if order.status == OrderStatus.Activated {
            try? realm.write {
                order.thaw()?.payoutStatus = PayoutStatus.Paid
            }
        }
    }
    
    var body: some View {
        Section(content: {
            if isCollapsed == false {
                HStack {
                    Text("Order Number")
                    Spacer()
                    TextField("Order Number", text: $order.number)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                }
                Menu {
                    Picker("", selection: $order.sellingDay) {
                        ForEach(1..<32, id: \.self) {
                        Text("Day \($0)")
                        }
                    }
                } label: {
                    HStack {
                        Text("Selling Day")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(order.sellingDay)")
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
                Menu {
                    Picker("", selection: $order.status) {
                        Text("\(OrderStatus.Processed.description)").tag(OrderStatus.Processed)
                        Text("\(OrderStatus.SecurePay.description)").tag(OrderStatus.SecurePay)
                        Text("\(OrderStatus.Activated.description)").tag(OrderStatus.Activated)
                        Text("\(OrderStatus.Cancelled.description)").tag(OrderStatus.Cancelled)
                    }
                } label: {
                    HStack {
                        Text("Order Status")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(order.status.description)")
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
                .onChange(of: order.status) { status in
                   UpdateStatuses()
                }
                Menu {
                    Picker("", selection: $order.payoutStatus) {
                        Text("\(PayoutStatus.Paid.description)").tag(PayoutStatus.Paid)
                        Text("\(PayoutStatus.Pending.description)").tag(PayoutStatus.Pending)
                        Text("\(PayoutStatus.Backordered.description)").tag(PayoutStatus.Backordered)
                        Text("\(PayoutStatus.NextMonth.description)").tag(PayoutStatus.NextMonth)
                        Text("\(PayoutStatus.Cancelled.description)").tag(PayoutStatus.Cancelled)
                    }
                } label: {
                    HStack {
                        Text("Expected Payout")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(order.payoutStatus.description)")
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
            }

        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}

struct OrderUnitsSection: View {
    @ObservedRealmObject var order: Order
    @State private var isCollapsed = false
    @State private var title = "Order Units"
    var body: some View {
        Section(content: {
            if isCollapsed == false {
                OrderUnitsRowInt(title: "PGA", symbol: "iphone.rear.camera", unit: $order.pga)
                OrderUnitsRowInt(title: "Renew", symbol: "iphone.rear.camera", unit: $order.renew)
                OrderUnitsRowInt(title: "PremUNL", symbol: "infinity", unit: $order.premUNL)
                OrderUnitsRowInt(title: "FWA", symbol: "wifi.router", unit: $order.fwa)
                OrderUnitsRowInt(title: "Tablet", symbol: "ipad.rear.camera", unit: $order.tablet)
                OrderUnitsRowInt(title: "Jetpack", symbol: "externaldrive", unit: $order.jetpack)
                OrderUnitsRowInt(title: "Conn Device", symbol: "applewatch", unit: $order.connDevice)
                OrderUnitsRowDouble(title: "Features", symbol: "lock.shield", unit: $order.features)
                OrderUnitsRowDouble(title: "ARD", symbol: "earbuds", unit: $order.ard)
            }
        }, header: {
            CollSectionHeader(title: $title, isCollapsed: $isCollapsed)
        })
    }
}

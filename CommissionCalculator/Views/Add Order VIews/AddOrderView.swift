//
//  AddOrderView.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct AddOrderView: View {
    @ObservedRealmObject var monthData: MonthData
    @ObservedRealmObject var newOrder: Order
    @Environment(\.dismiss) var dismiss
    @Binding var isPriorOrder: Bool
    @FocusState var editingNumber: Bool
    
        func UpdateStatuses() {
        if newOrder.status == OrderStatus.Cancelled {
            newOrder.payoutStatus = PayoutStatus.Cancelled
        } else if newOrder.status == OrderStatus.Activated {
            newOrder.payoutStatus = PayoutStatus.Paid
        }
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Group {
                        Text("Payout: ") +
                        Text("$\(newOrder.UnitsPayoutCalc(), specifier:  "%.2f")").foregroundColor(.green)
                    }
                    Spacer()
                }.padding(.bottom, 10)
            List {
                Section {
                    HStack {
                        Text("Order Number")
                        Spacer()
                        TextField("Order Number", text: $newOrder.number)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.trailing)
                        .focused($editingNumber)
                        .keyboardType(.numbersAndPunctuation)
                    }
                    Menu {
                        Picker("", selection: $newOrder.sellingDay) {
                            ForEach(1..<32, id: \.self) {
                            Text("Day \($0)")
                            }
                        }
                    } label: {
                        HStack {
                            Text("Selling Day")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(newOrder.sellingDay)")
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                        }
                    }
                    Menu {
                        Picker("", selection: $newOrder.status) {
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
                            Text("\(newOrder.status.description)")
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                        }
                    }
                    .onChange(of: newOrder.status) { status in
                        UpdateStatuses()
                    }
                    Menu {
                        Picker("", selection: $newOrder.payoutStatus) {
                            Text("\(PayoutStatus.Pending.description)").tag(PayoutStatus.Pending)
                            Text("\(PayoutStatus.Backordered.description)").tag(PayoutStatus.Backordered)
                            Text("\(PayoutStatus.NextMonth.description)").tag(PayoutStatus.NextMonth)
                            Text("\(PayoutStatus.Cancelled.description)").tag(PayoutStatus.Cancelled)
                        }
                    } label: {
                        HStack {
                            Text("Commission Status")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(newOrder.payoutStatus.description)")
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                        }
                    }
                }
                Section {
                    OrderUnitsRowInt(title: "PGA", symbol: "iphone", unit: $newOrder.pga)
                    OrderUnitsRowInt(title: "Renew", symbol: "candybarphone", unit: $newOrder.renew)
                    OrderUnitsRowInt(title: "PremUNL", symbol: "infinity", unit: $newOrder.premUNL)
                    OrderUnitsRowInt(title: "FWA", symbol: "wifi.router", unit: $newOrder.fwa)
                    OrderUnitsRowInt(title: "Tablet", symbol: "ipad.rear.camera", unit: $newOrder.tablet)
                    OrderUnitsRowInt(title: "Jetpack", symbol: "externaldrive", unit: $newOrder.jetpack)
                    OrderUnitsRowInt(title: "Conn Device", symbol: "applewatch", unit: $newOrder.connDevice)
                    OrderUnitsRowDouble(title: "Features", symbol: "lock.shield", unit: $newOrder.features)
                    OrderUnitsRowDouble(title: "ARD", symbol: "earbuds", unit: $newOrder.ard)

                }
            }
            }
            .navigationTitle("Add Order")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading) {
                    Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        }
                }
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button {
                        if isPriorOrder == false {
                            $monthData.orders.append(newOrder)
                        } else {
                            $monthData.priorMonthOrders.append(newOrder)
                        }
                        dismiss()
                    } label: {
                        Text("Save")
                            .foregroundColor(.blue)
                            .opacity(newOrder.number == "" ? 0.5 : 1.0)
                    }.disabled(newOrder.number.isEmpty)
                }
                
            }
            .onAppear {
                editingNumber.toggle()
            }
        }
    }
}

struct OrderUnitsRowInt: View {
    @State var title: String
    @State var symbol: String
    @Binding var unit: Int
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text(title)
            Spacer()
            Button {
                unit += 1
            } label: {
                Image(systemName: "plus.circle.fill")
                    .rowSymbolModifier()
                    .foregroundColor(.blue)
            }.buttonStyle(.plain)
            Button {
                unit -= 1
            } label: {
                Image(systemName: "minus.circle.fill")
                    .rowSymbolModifier()
                    .foregroundColor(.red)
                    .opacity(unit == 0 ? 0.5 : 1.0)
            }.buttonStyle(.plain).disabled(unit == 0)
            .padding(.trailing, 5)
            Text("\(unit)")
                .foregroundColor(.secondary)
        }
    }
}

struct OrderUnitsRowDouble: View {
    @State var title: String
    @State var symbol: String
    @Binding var unit: Double
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .rowSymbolModifier()
                .foregroundColor(.secondary)
            Text(title)
            Spacer()
            TextField("0", value: $unit, formatter: currencyFormatter)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .foregroundColor(.blue)
            
        }
    }
}

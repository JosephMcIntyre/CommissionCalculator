//
//  WorkdayDetail.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/14/22.
//

import SwiftUI
import RealmSwift

struct WorkdayDetail: View {
    @Binding var sellingDay: Int
    @ObservedRealmObject var monthData: MonthData
    
    var body: some View {
        List {
            WorkdaySectionSummary(sellingDay: $sellingDay, monthData: monthData)
            WorkdaySectionPending(sellingDay: $sellingDay, monthData: monthData)
            WorkdaySectionBackorder(sellingDay: $sellingDay, monthData: monthData)
            WorkdaySectionNextMonth(sellingDay: $sellingDay, monthData: monthData)
            WorkdaySectionCancelled(sellingDay: $sellingDay, monthData: monthData)
        }
    }
}

struct WorkdaySectionSummary: View {
    @Binding var sellingDay: Int
    @ObservedRealmObject var monthData: MonthData
    
    func CalcPayout() -> Double {
        let payout = monthData.CalcWorkDayPayout(workDay: sellingDay, status: PayoutStatus.Paid) + monthData.CalcWorkDayPayout(workDay: sellingDay, status: PayoutStatus.Pending) + monthData.CalcWorkDayPayout(workDay: sellingDay, status: PayoutStatus.Backordered)
        return payout
    }
    var body: some View {
        Section(content: {
            HStack {
                Text("Total Rev:")
                Spacer()
                Text("$\(CalcPayout(), specifier: "%.2f")")
                    .foregroundColor(.green)
                
            }
        }, header: {
            Text("Summary")
        })
    }
}

struct WorkdaySectionPending: View {
    @Binding var sellingDay: Int
    @ObservedRealmObject var monthData: MonthData
    
    func delete(at offsets: IndexSet) {
        $monthData.orders.remove(atOffsets: offsets)
    }
    
    var body: some View {
        Section(content: {
            ForEach(monthData.orders, id: \.id) { order in
                if order.sellingDay == sellingDay && order.payoutStatus != PayoutStatus.Cancelled && order.payoutStatus != PayoutStatus.Backordered && order.payoutStatus != PayoutStatus.NextMonth {
                    NavigationLink(destination: {
                        OrderDetails(order: order, monthData: monthData)
                    }, label: {
                        OrderRow(order: order)
                    })
                }
            }
            .onMove(perform: monthData.MoveOrder)
            .onDelete(perform: delete)
        }, header: {
            Text(" Pending & Paid")
        })
    }
}

struct WorkdaySectionBackorder: View {
    @Binding var sellingDay: Int
    @ObservedRealmObject var monthData: MonthData
    
    func delete(at offsets: IndexSet) {
        $monthData.orders.remove(atOffsets: offsets)
    }
    
    var body: some View {
        Section(content: {
            ForEach(monthData.orders, id: \.id) { order in
                if order.sellingDay == sellingDay && order.payoutStatus == PayoutStatus.Backordered {
                    NavigationLink(destination: {
                        OrderDetails(order: order, monthData: monthData)
                    }, label: {
                        OrderRow(order: order)
                    })
                }
            }
            .onMove(perform: monthData.MoveOrder)
            .onDelete(perform: delete)
        }, header: {
            Text("Backordered for This Month")
        })
    }
}

struct WorkdaySectionNextMonth: View {
    @Binding var sellingDay: Int
    @ObservedRealmObject var monthData: MonthData
    
    func delete(at offsets: IndexSet) {
        $monthData.orders.remove(atOffsets: offsets)
    }
    
    var body: some View {
        Section(content: {
            ForEach(monthData.orders, id: \.id) { order in
                if order.sellingDay == sellingDay && order.payoutStatus == PayoutStatus.NextMonth {
                    NavigationLink(destination: {
                        OrderDetails(order: order, monthData: monthData)
                    }, label: {
                        OrderRow(order: order)
                    })
                }
            }
            .onMove(perform: monthData.MoveOrder)
            .onDelete(perform: delete)
        }, header: {
            Text("Backordered for Next Month")
        })
    }
}

struct WorkdaySectionCancelled: View {
    @Binding var sellingDay: Int
    @ObservedRealmObject var monthData: MonthData
    
    func delete(at offsets: IndexSet) {
        $monthData.orders.remove(atOffsets: offsets)
    }
    
    var body: some View {
        Section(content: {
            ForEach(monthData.orders, id: \.id) { order in
                if order.sellingDay == sellingDay && order.payoutStatus == PayoutStatus.Cancelled {
                    NavigationLink(destination: {
                        OrderDetails(order: order, monthData: monthData)
                    }, label: {
                        OrderRow(order: order)
                    })
                }
            }
            .onMove(perform: monthData.MoveOrder)
            .onDelete(perform: delete)
        }, header: {
            Text("Cancelled ")
        })
    }
}

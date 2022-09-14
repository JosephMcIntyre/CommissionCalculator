//
//  Data.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/13/22.
//

import SwiftUI
import RealmSwift

class MonthData: Object, ObjectKeyIdentifiable  {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var orders: RealmSwift.List<Order>
    @Persisted var priorMonthOrders: RealmSwift.List<Order>
    
    @Persisted var pga: Int = 0
    @Persisted var renew: Int = 0
    @Persisted var premUNL: Int = 0
    @Persisted var fwa: Int = 0
    @Persisted var tablet: Int = 0
    @Persisted var jetpack: Int = 0
    @Persisted var connDevice: Int = 0
    @Persisted var features: Double = 0
    @Persisted var ard: Double = 0
    
    func UnitsPayoutCalc() -> Double {
        var payout: Double = 0
        payout = Double(pga * 100) + Double(renew * 20) + Double(premUNL * 20) + Double(fwa * 100) + Double(tablet * 50) + Double(jetpack * 50) + Double(connDevice * 20) + features + (ard * 0.15)
        return payout
    }
    func UnitsPayoutCalcNews() -> Double {
        var payout: Double = 0
        payout = Double(pga * 100) + Double(fwa * 100)
        return payout
    }
    
    func CountTotalUnits() -> [Double] {
        var results: [Double] = [0,0,0,0,0,0,0,0,0]
        let selectedOrders = orders.filter { $0.payoutStatus != PayoutStatus.Cancelled && $0.payoutStatus != PayoutStatus.NextMonth}
        for i in selectedOrders.indices {
            results[0] += Double(selectedOrders[i].pga)
            results[1] += Double(selectedOrders[i].renew)
            results[2] += Double(selectedOrders[i].premUNL)
            results[3] += Double(selectedOrders[i].fwa)
            results[4] += Double(selectedOrders[i].tablet)
            results[4] += Double(selectedOrders[i].jetpack)
            results[5] += Double(selectedOrders[i].connDevice)
            results[6] += selectedOrders[i].features
            results[7] += selectedOrders[i].ard
        }
        let priorOrders = priorMonthOrders
        for i in priorOrders.indices {
            results[0] += Double(priorOrders[i].pga)
            results[1] += Double(priorOrders[i].renew)
            results[2] += Double(priorOrders[i].premUNL)
            results[3] += Double(priorOrders[i].fwa)
            results[4] += Double(priorOrders[i].tablet)
            results[4] += Double(priorOrders[i].jetpack)
            results[5] += Double(priorOrders[i].connDevice)
            results[6] += priorOrders[i].features
            results[7] += priorOrders[i].ard
        }
        results[0] -= Double(pga)
            results[1] -= Double(renew)
            results[2] -= Double(premUNL)
            results[3] -= Double(fwa)
            results[4] -= Double(tablet)
            results[4] -= Double(jetpack)
            results[5] -= Double(connDevice)
            results[6] -= features
            results[7] -= ard
        results[8] = results[7] * 0.15
        return results
    }
    
    func CountOrderUnits(status: PayoutStatus) -> [Double] {
        var results: [Double] = [0,0,0,0,0,0,0,0,0]
        let selectedOrders = orders.filter { $0.payoutStatus == status}
        for i in selectedOrders.indices {
            results[0] += Double(selectedOrders[i].pga)
            results[1] += Double(selectedOrders[i].renew)
            results[2] += Double(selectedOrders[i].premUNL)
            results[3] += Double(selectedOrders[i].fwa)
            results[4] += Double(selectedOrders[i].tablet)
            results[4] += Double(selectedOrders[i].jetpack)
            results[5] += Double(selectedOrders[i].connDevice)
            results[6] += selectedOrders[i].features
            results[7] += selectedOrders[i].ard
        }
        results[8] = results[7] * 0.15
        return results
    }
    
    func CountPriorMonthUnits() -> [Double] {
        var results: [Double] = [0,0,0,0,0,0,0,0,0]
        let selectedOrders = priorMonthOrders
        for i in selectedOrders.indices {
            results[0] += Double(selectedOrders[i].pga)
            results[1] += Double(selectedOrders[i].renew)
            results[2] += Double(selectedOrders[i].premUNL)
            results[3] += Double(selectedOrders[i].fwa)
            results[4] += Double(selectedOrders[i].tablet)
            results[4] += Double(selectedOrders[i].jetpack)
            results[5] += Double(selectedOrders[i].connDevice)
            results[6] += selectedOrders[i].features
            results[7] += selectedOrders[i].ard
        }
        results[8] = results[7] * 0.15
        return results
    }
    
    func CalcWorkDayPayout(workDay: Int, status: PayoutStatus) -> Double {
        var payout: Double = 0
        let selectedOrders = orders.filter { $0.sellingDay == workDay && $0.payoutStatus == status }
        for i in selectedOrders.indices {
            payout += selectedOrders[i].UnitsPayoutCalc()
        }
        return payout
    }
    
    func CalcWorkdayOrderCount(workDay: Int, status: PayoutStatus) -> Int {
        let selectedOrders = orders.filter { $0.sellingDay == workDay && $0.payoutStatus == status }
        let count = selectedOrders.count
        return count
    }
    
    
    
    func CalcTotalRevSold() -> Double {
        let payout: Double = CalcMonthSalesRev() + CalcPriorMonthPayout() - UnitsPayoutCalc()
        return payout
    }
    
    
    func CalcMonthPayout(status: PayoutStatus) -> Double {
        var payout: Double = 0
        let selectedOrders = orders.filter { $0.payoutStatus == status }
        for i in selectedOrders.indices {
            payout += selectedOrders[i].UnitsPayoutCalc()
        }
        return payout
    }
    
    func CalcMonthOrderCount(status: PayoutStatus) -> Int {
        let selectedOrders = orders.filter { $0.payoutStatus == status }
        let count = selectedOrders.count
        return count
    }
    
    func CalcPriorMonthPayout() -> Double {
        var payout: Double = 0
        let selectedOrders = priorMonthOrders
        for i in selectedOrders.indices {
            payout += selectedOrders[i].UnitsPayoutCalc()
        }
        return payout
    }
    
    func CalcPriorMonthOrderCount() -> Int {
        let selectedOrders = priorMonthOrders
        let count = selectedOrders.count
        return count
    }
    
    func MoveOrder(from source: IndexSet, to destination: Int) {
        orders.move(fromOffsets: source, toOffset: destination)
    }
    
    func CalcMonthSalesRev() -> Double {
        var payout: Double = 0
        let selectedOrders = orders.filter { $0.payoutStatus != PayoutStatus.Cancelled && $0.payoutStatus != PayoutStatus.NextMonth }
        for i in selectedOrders.indices {
            payout += selectedOrders[i].UnitsPayoutCalc()
        }
        return payout
    }
    func CalcMonthNewsRev() -> Double {
        var payout: Double = 0
        let selectedOrders = orders.filter { $0.payoutStatus != PayoutStatus.Cancelled && $0.payoutStatus != PayoutStatus.NextMonth }
        for i in selectedOrders.indices {
            payout += selectedOrders[i].UnitsPayoutCalcNews()
        }
        return payout
    }
}

class Order: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted(originProperty: "orders") var group: LinkingObjects<MonthData>
    
    @Persisted var status = OrderStatus.Processed
    @Persisted var payoutStatus = PayoutStatus.Pending
    
    @Persisted var number: String = ""
    @Persisted var sellingDay = 1
    
    @Persisted var pga: Int = 0
    @Persisted var renew: Int = 0
    @Persisted var premUNL: Int = 0
    @Persisted var fwa: Int = 0
    @Persisted var tablet: Int = 0
    @Persisted var jetpack: Int = 0
    @Persisted var connDevice: Int = 0
    @Persisted var features: Double = 0
    @Persisted var ard: Double = 0
    
    func UnitsPayoutCalc() -> Double {
        var payout: Double = 0
        payout = Double(pga * 100) + Double(renew * 20) + Double(premUNL * 20) + Double(fwa * 100) + Double(tablet * 50) + Double(jetpack * 50) + Double(connDevice * 20) + features + (ard * 0.15)
        return payout
    }
    func UnitsPayoutCalcNews() -> Double {
        var payout: Double = 0
        payout = Double(pga * 100) + Double(fwa * 100)
        return payout
    }
}

enum OrderStatus: String, PersistableEnum {
    case Processed
    case SecurePay
    case Activated
    case Cancelled
    
    var description: String {
        switch self {
            case .Processed: return "Processed"
            case .SecurePay: return "SecurePay"
            case .Activated: return "Activated"
            case .Cancelled: return "Cancelled"
        }
    }
}

enum PayoutStatus: String, PersistableEnum {
    case Pending
    case Paid
    case Backordered
    case NextMonth
    case Cancelled
    
    var description: String {
        switch self {
            case .Pending: return "Pending"
            case .Paid: return "Paid"
            case .Backordered: return "Backordered"
            case .NextMonth: return "Next Month"
            case .Cancelled: return "Cancelled"
        }
    }
}


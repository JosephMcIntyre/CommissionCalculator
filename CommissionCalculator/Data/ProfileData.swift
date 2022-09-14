//
//  Data2.swift
//  RealmTest
//
//  Created by Joseph McIntyre on 9/13/22.
//

import SwiftUI
import RealmSwift


class Profile: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var empStatus = EmpStatus.FT
    @Persisted var pto: Double = 0
    @Persisted var ptoException = false
    @Persisted var salesRev: Double = 10000
    @Persisted var newRev: Double = 6000
    
    
    @Persisted var totalSellingDays: Int = 22
    @Persisted var currSellingDay: Int = 1
    
    func calcSalesRelief() -> Double {
        let percentOff = (empStatus.hoursMonth-(pto*8)) / empStatus.hoursMonth
        var adjustedSalesRev = salesRev
        if ptoException == true || pto >= 3 {
            adjustedSalesRev *= percentOff
        }
        return adjustedSalesRev
    }
    func calcNewRelief() -> Double {
        let percentOff = (empStatus.hoursMonth-(pto*8)) / empStatus.hoursMonth
        var adjustedNewRev = newRev
        if ptoException == true || pto >= 3 {
            adjustedNewRev *= percentOff
        }
        return adjustedNewRev
    }
}

enum EmpStatus: String, PersistableEnum {
    case FT
    case PT32
    case PT24
    
    var id: EmpStatus { self }
    
    var description: String {
        switch self {
            case .FT: return "Full-time"
            case .PT32: return "Part-time 32"
            case .PT24: return "Part-time 24"
        }
    }
    
    var hoursWeek: Int {
        switch self {
            case .FT: return 40
            case .PT32: return 32
            case .PT24: return 24
        }
    }
    
    var hoursMonth: Double {
        switch self {
            case .FT: return 176
            case .PT32: return 140.8
            case .PT24: return 105.6
        }
    }
    
    var atRisk: Double {
        switch self {
            case .FT: return 1250
            case .PT32: return 1000
            case .PT24: return 750
        }
    }
}




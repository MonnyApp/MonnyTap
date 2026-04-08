//
//  Category.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Identifiable, Codable {
    case fnb = "FnB"
    case investment = "Investment"
    case education = "Education"
    case shopping = "Shopping"
    case entertainment = "Entertainment"
    case health = "Health"
    case travels = "Travels"
    case transportation = "Transportation"
    case other = "Other"

    var id: String {
        rawValue
    }

    var icon: String {
        switch self {
            case .fnb: return "fork.knife"
            case .investment: return "dollarsign.bank.building.fill"
            case .education: return "graduationcap.fill"
            case .shopping: return "handbag.fill"
            case .entertainment: return "gamecontroller.fill"
            case .health: return "heart.fill"
            case .travels: return "figure.walk"
            case .transportation: return "car.fill"
            case .other: return "lightbulb.fill"
        }
    }

    // Belum fix, nunggu assets warna lebih lanjut
    /*
      var color: Color {
         switch self {
         case .fnb:          return .orange
         case .investment:     return .blue
         case .education:      return .pink
         case .shopping:        return .red
         case .entertainment:     return .purple
         case .health:       return .brown
         case .travels:         return .yellow
         case .transportation: return .green
         case .other:         return .gray
         }
     }
      */

    // Belum fix, nunggu assets warna lebih lanjut
    /*
     var iconColor: Color {
        switch self {
        case .fnb:          return .orange
        case .investment:     return .blue
        case .education:      return .pink
        case .shopping:        return .red
        case .entertainment:     return .purple
        case .health:       return .brown
        case .travels:         return .yellow
        case .transportation: return .green
        case .other:         return .gray
        }
    }
     }
      */
}


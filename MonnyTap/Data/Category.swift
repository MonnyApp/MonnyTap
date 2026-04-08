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
         case .food:          return .orange
         case .transport:     return .blue
         case .shopping:      return .pink
         case .health:        return .red
         case .education:     return .purple
         case .housing:       return .brown
         case .bills:         return .yellow
         case .entertainment: return .green
         case .other:         return .gray
         }
     }
      */

    // Belum fix, nunggu assets warna lebih lanjut
    /*
      var iconColor: Color {
         switch self {
         case .food:          return .orange
         case .transport:     return .blue
         case .shopping:      return .pink
         case .health:        return .red
         case .education:     return .purple
         case .housing:       return .brown
         case .bills:         return .yellow
         case .entertainment: return .green
         case .other:         return .gray
         }
     }
      */
}

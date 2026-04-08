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


      var color: Color {
         switch self {
         case .fnb:          return Color("yellowmonny")
         case .investment:     return Color("orangemonny")
         case .education:      return Color("bluemonny")
         case .shopping:        return Color("pinkmonny")
         case .entertainment:     return Color("purplemonny")
         case .health:       return Color("redmonny")
         case .travels:         return Color("Chocomonny")
         case .transportation: return Color("toscamonny")
         case .other:         return Color("greymonny")
         }
     }
      
     var iconColor: Color {
        switch self {
        case .fnb:          return Color("yellowicon")
        case .investment:     return Color("orangeicon")
        case .education:      return Color("blueicon")
        case .shopping:        return Color("pinkicon")
        case .entertainment:     return Color("purpleicon")
        case .health:       return Color("redicon")
        case .travels:         return Color("chocoicon")
        case .transportation: return Color("toscaicon")
        case .other:         return Color("greyicon")
        }
    }
}


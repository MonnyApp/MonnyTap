//
//  Category.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import Foundation
import SwiftUI

/// Representasi kategori untuk setiap transaksi pengeluaran.
/// Enum ini memuat daftar kategori beserta ikon SF Symbols dan warna uniknya untuk keperluan UI.
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
    case income = "Income"

    
    /// ID unik yang dibutuhkan oleh protokol `Identifiable`, menggunakan nilai String bawaan (rawValue).
    var id: String {
        rawValue
    }
    
    /// Mengembalikan nama ikon SF Symbols yang sesuai dengan kategori.
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
        case .income: return "dollarsign"
        }
    }
    
    /// Mengembalikan warna latar belakang lingkaran dari Assets Catalog.
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
        case .income:         return Color("greenmonny")
        }
    }
    
    /// Mengembalikan warna solid untuk ikon dari Assets Catalog.
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
        case .income:         return Color("greenincome")
        }
    }
}


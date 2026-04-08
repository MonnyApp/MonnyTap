//
//  MockData.swift
//  MonnyTap
//
//  Created by Ivone Liwang on 08/04/26.
//

import SwiftUI

// ============================================================
// MOCK DATA FILE
// File ini berisi:
// 1. Definisi model (Transaction, TransactionCategory)
// 2. Data dummy sementara
//
// UNTUK REKAM TIM:
// Ketika data asli sudah siap, cukup ganti bagian
// di bawah tanda "DATA DUMMY - GANTI DI SINI"
// Jangan ubah bagian struct dan enum di atas garis itu.
// ============================================================


// MARK: - Model

struct Transactions: Identifiable, Codable {
    var id: UUID
    var name: String
    var amount: Double
    var category: TransactionCategory
    var date: Date
    var isIncome: Bool

    init(
        id: UUID = UUID(),
        name: String,
        amount: Double,
        category: TransactionCategory,
        date: Date = Date(),
        isIncome: Bool = false
    ) {
        self.id       = id
        self.name     = name
        self.amount   = amount
        self.category = category
        self.date     = date
        self.isIncome = isIncome
    }
}


// MARK: - Kategori

enum TransactionCategory: String, CaseIterable, Codable, Identifiable {
    case fnb           = "FnB"
    case income        = "Income"
    case travels       = "Travels"
    case shopping      = "Shopping"
    case food          = "Food"
    case housing       = "Housing"
    case education     = "Education"
    case entertainment = "Entertainment"
    case utilities     = "Utilities"
    case vehicle       = "Vehicle"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .fnb:           return "fork.knife"
        case .income:        return "dollarsign.circle"
        case .travels:       return "figure.walk"
        case .shopping:      return "bag"
        case .food:          return "fork.knife.circle"
        case .housing:       return "house"
        case .education:     return "graduationcap"
        case .entertainment: return "gamecontroller"
        case .utilities:     return "lightbulb"
        case .vehicle:       return "car"
        }
    }

    var color: Color {
        switch self {
        case .housing:       return Color(hex: "#FF8C55")
        case .education:     return Color(hex: "#A8C8F0")
        case .income:        return Color(hex: "#F4A0B0")
        case .shopping:      return Color(hex: "#C8956A")
        case .utilities:     return Color(hex: "#A0A0A8")
        case .fnb:           return Color(hex: "#F5C842")
        case .travels:       return Color(hex: "#60C8B0")
        case .vehicle:       return Color(hex: "#78D0C0")
        case .food:          return Color(hex: "#F08080")
        case .entertainment: return Color(hex: "#C8A0E0")
        }
    }
}

// Helper: Color dari hex string
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >>  8) & 0xFF) / 255
        let b = Double( int        & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}


// MARK: - DATA DUMMY - GANTI DI SINI
// Bagian di bawah ini yang akan diganti rekam tim
// ketika data asli sudah tersedia.

struct MockData {

    // Saldo, income, expense
    static let balance: Double = 5_000_000
    static let income:  Double = 58_000_000
    static let expense: Double = 30_000
    static let month:   String = "August, 2026"

    // Daftar transaksi (sesuai screenshot)
    static let transactions: [Transaction] = [
        Transaction(
            name: "Ayam Geprek Wani",
            amount: 13_000,
            category: .fnb,
            isIncome: false
        ),
        Transaction(
            name: "Stipen Apple Developer Academy",
            amount: 5_290_000,
            category: .income,
            isIncome: true
        ),
        Transaction(
            name: "Bali Trip",
            amount: 53_000,
            category: .travels,
            isIncome: false
        ),
        Transaction(
            name: "Sketchbook",
            amount: 13_000,
            category: .shopping,
            isIncome: false
        ),
        Transaction(
            name: "Mie ayam enak",
            amount: 13_000,
            category: .food,
            isIncome: false
        ),
    ]

    // Data donut chart per kategori (sesuai screenshot)
    // Tuple: (kategori, persentase 0.0–1.0)
    static let analyticsData: [(TransactionCategory, Double)] = [
        (.housing,       0.30),
        (.education,     0.12),
        (.income,        0.11),
        (.shopping,      0.10),
        (.utilities,     0.15),
        (.fnb,           0.08),
        (.vehicle,       0.04),
        (.travels,       0.06),
        (.entertainment, 0.04),
    ]
}

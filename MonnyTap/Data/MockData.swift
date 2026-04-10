//
//  MockData.swift
//  MonnyTap
//
//  Created by Ivone Liwang on 08/04/26.
//

import Foundation

// ============================================================
// FILE INI ADALAH DATA DUMMY SEMENTARA
//
// UNTUK REKAN TIM:
// Ketika data asli SwiftData sudah siap, hapus file ini
// dan ganti properti di OverviewViewModel dengan
// query SwiftData sesungguhnya.
// ============================================================

struct MockData {
    private static let calendar = Calendar(identifier: .gregorian)

    static let balance: Int    = 5_000_000
    static let income:  Int    = 58_000_000
    static let expense: Int    = 30_000
    static let month:   String = "August, 2026"

    static let transactions: [Transaction] = [

        // Income
        Transaction(type: .income,  title: "Stipen Apple Developer Academy", amount: 5_290_000, date: date(day: 8, month: 4, year: 2026), category: .investment),

        // FnB
        Transaction(type: .expense, title: "Ayam Geprek Wani",   amount: 13_000,  date: date(day: 8, month: 4, year: 2026), category: .fnb),
        Transaction(type: .expense, title: "Mie ayam enak",      amount: 13_000,  date: date(day: 7, month: 4, year: 2026), category: .fnb),
        Transaction(type: .expense, title: "Kopi Kenangan",      amount: 25_000,  date: date(day: 9, month: 4, year: 2026), category: .fnb),

        // Travels
        Transaction(type: .expense, title: "Bali Trip",          amount: 53_000,  date: date(day: 5, month: 4, year: 2026), category: .travels),
        Transaction(type: .expense, title: "Tiket kereta",       amount: 75_000,  date: date(day: 10, month: 4, year: 2026), category: .travels),

        // Shopping
        Transaction(type: .expense, title: "Sketchbook",         amount: 13_000,  date: date(day: 6, month: 4, year: 2026), category: .shopping),
        Transaction(type: .expense, title: "Baju baru",          amount: 120_000, date: date(day: 11, month: 4, year: 2026), category: .shopping),

        // Transportation
        Transaction(type: .expense, title: "Grab ke kampus",     amount: 25_000,  date: date(day: 8, month: 4, year: 2026), category: .transportation),
        Transaction(type: .expense, title: "Bensin",             amount: 50_000,  date: date(day: 4, month: 4, year: 2026), category: .transportation),
        Transaction(type: .expense, title: "Parkir mall",        amount: 10_000,  date: date(day: 12, month: 4, year: 2026), category: .transportation),

        // Education
        Transaction(type: .expense, title: "Buku Swift",         amount: 120_000, date: date(day: 7, month: 4, year: 2026), category: .education),
        Transaction(type: .expense, title: "Kursus online",      amount: 150_000, date: date(day: 13, month: 4, year: 2026), category: .education),

        // Entertainment
        Transaction(type: .expense, title: "Netflix",            amount: 54_000,  date: date(day: 3, month: 4, year: 2026), category: .entertainment),
        Transaction(type: .expense, title: "Spotify",            amount: 29_000,  date: date(day: 9, month: 4, year: 2026), category: .entertainment),

        // Health
        Transaction(type: .expense, title: "Beli obat",          amount: 45_000,  date: date(day: 6, month: 4, year: 2026), category: .health),
        Transaction(type: .expense, title: "Vitamin",            amount: 80_000,  date: date(day: 10, month: 4, year: 2026), category: .health),

        // Other
        Transaction(type: .expense, title: "Bayar listrik",      amount: 200_000, date: date(day: 2, month: 4, year: 2026), category: .other),
        Transaction(type: .expense, title: "Iuran kebersihan",   amount: 30_000,  date: date(day: 14, month: 4, year: 2026), category: .other),
    ]

    private static func date(day: Int, month: Int, year: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return calendar.date(from: components) ?? .now
    }
}

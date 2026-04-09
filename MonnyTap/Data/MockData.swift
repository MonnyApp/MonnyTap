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
// Ketika data asli sudah siap, file ini tidak perlu dipakai.
// Cukup hapus MockData dari FinanceViewModel dan ganti
// dengan query SwiftData yang sesungguhnya.
// ============================================================

struct MockData {

    // Ringkasan saldo — sesuai screenshot
    static let balance: Int    = 5_000_000
    static let income:  Int    = 58_000_000
    static let expense: Int    = 30_000
    static let month:   String = "August, 2026"

    // Daftar transaksi — sesuai screenshot
    static let transactions: [Transaction] = [
        Transaction(
            type: .expense,
            title: "Ayam Geprek Wani",
            amount: 13_000,
            date: .now,
            category: .fnb
        ),
        Transaction(
            type: .income,
            title: "Stipen Apple Developer Academy",
            amount: 5_290_000,
            date: .now,
            category: .investment
        ),
        Transaction(
            type: .expense,
            title: "Bali Trip",
            amount: 53_000,
            date: .now,
            category: .travels
        ),
        Transaction(
            type: .expense,
            title: "Sketchbook",
            amount: 13_000,
            date: .now,
            category: .shopping
        ),
        Transaction(
            type: .expense,
            title: "Mie ayam enak",
            amount: 13_000,
            date: .now,
            category: .fnb
        ),
    ]

    // Data donut chart — sesuai screenshot
    // Tuple: (kategori, persentase 0.0–1.0)
    static let analyticsData: [(Category, Double)] = [
        (.transportation, 0.30),
        (.education,      0.12),
        (.investment,     0.11),
        (.shopping,       0.10),
        (.other,          0.15),
        (.fnb,            0.08),
        (.travels,        0.06),
        (.entertainment,  0.04),
        (.health,         0.04),
    ]
}

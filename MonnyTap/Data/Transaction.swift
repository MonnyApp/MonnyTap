//
//  Transaction.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import Foundation
import SwiftUI
import SwiftData

/// Representasi model data untuk setiap transaksi yang dicatat oleh pengguna.
/// Model ini menggunakan SwiftData untuk penyimpanan lokal.
@Model
final class Transaction {
    /// ID unik untuk setiap transaksi.
    var id: UUID
    /// Jenis transaksi, apakah itu pemasukan (Income) atau pengeluaran (Expense).
    var type: TransactionType
    /// Nama atau deskripsi singkat dari transaksi yang diinput pengguna.
    var title: String
    /// Nominal transaksi dalam satuan angka bulat (Integer).
    var amount: Int
    /// Waktu dan tanggal transaksi dicatat.
    var date: Date
    /// Kategori transaksi. Jika pengguna tidak memilih, sistem akan otomatis menetapkan `.other`.
    var category: Category?
    
    init(
        id: UUID = UUID(),
        type: TransactionType,
        title: String,
        amount: Int,
        date: Date = .now,
        category: Category = .other //default nya jadi kategori other
    )
    {
        self.id = id
        self.type = type
        self.title = title
        self.amount = amount
        self.date = date
        self.category = category
    }
}

enum TransactionType: String, Codable {
    case expense = "Expense"
    case income = "Income"

    var iconBackgroundColor: Color {
        switch self {
        case .income:
            return Color("greenmonny").opacity(0.2)
        case .expense:
            return Color("yellowmonny").opacity(0.2)
        }
    }

    var iconColor: Color {
        switch self {
        case .income:
            return Color("greenincome")
        case .expense:
            return Color("redicon")
        }
    }

    var amountColor: Color {
        switch self {
        case .income:
            return Color("greenincome")
        case .expense:
            return Color("redicon")
        }
    }
}
//sample data
extension Transaction {
    static var sampleIncome: Transaction {
        Transaction(
            type: .income,
            title: "Stipend Apple Academy",
            amount: 5_290_000,
            date: .now,
            category: .education
        )
    }
}

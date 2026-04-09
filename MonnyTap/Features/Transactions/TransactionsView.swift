//
//  TransactionsView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
//tampilan slide
struct DateItem: View {
    let day: String
    let date: String
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            Text(day).font(.system(size: 12)).foregroundColor(isSelected ? .white : .gray)
            Text(date).font(.system(size: 14, weight: .bold)).foregroundColor(isSelected ? .white : .black)
        }
        .frame(width: 45, height: 60)
        .background(isSelected ? Color(red: 45/255, green: 110/255, blue: 135/255) : Color.clear)
        .cornerRadius(12)
    }
}

struct TransactionsView: View {
    private let transactions: [Transaction] = [.sampleIncome]
    
    // state untuk picker tanggal
    @State private var selectedDate: String = "02"
    
    let dates = [
        (day: "Fri", date: "31"), (day: "Sat", date: "01"),
        (day: "Sun", date: "02"), (day: "Mon", date: "03"),
        (day: "Tue", date: "04"), (day: "Wed", date: "05")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // --- HEADER ---
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .padding(10)
                        .background(Circle().fill(Color.gray.opacity(0.05)))
                }
                Spacer()
                Text("Transactions").font(.system(size: 18, weight: .bold))
                Spacer()
                Button(action: {}) {
                    Image(systemName: "calendar")
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.05)))
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // --- FUNCTIONAL DATE PICKER ---
            HStack {
                Button(action: {}) { Image(systemName: "chevron.left") }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(dates, id: \.date) { item in
                            DateItem(day: item.day, date: item.date, isSelected: selectedDate == item.date)
                                .onTapGesture {
                                    withAnimation(.spring()) { selectedDate = item.date }
                                }
                        }
                    }
                    .padding(.vertical, 5)
                }
                
                Button(action: {}) { Image(systemName: "chevron.right") }
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            
            // --- TRANSACTION LIST ---
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    if transactions.isEmpty {
                        Text("No Transactions").foregroundColor(.gray).padding(.top, 50)
                    } else {
                        ForEach(transactions) { transaction in
                            AllTransactionCard(transaction: transaction)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(white: 0.98).ignoresSafeArea())
    }
}


#Preview {
    TransactionsView()
}

//
//  TransactionsView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI

//tampilan slide
struct DateItem: View {
    let date: Date
    var isSelected: Bool

    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 6) {
            Text(Self.dayFormatter.string(from: date))
                .font(.system(size: 12))
                .foregroundColor(isSelected ? .white : .gray)
            Text(Self.dateFormatter.string(from: date))
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(isSelected ? .white : .black)
        }
        .frame(width: 45, height: 60)
        .background(isSelected ? Color(red: 45/255, green: 110/255, blue: 135/255) : Color.clear)
        .cornerRadius(12)
    }
}

struct TransactionsView: View {
    private let transactions: [Transaction] = [.sampleIncome]
    
    // Tanggal aktif selalu menjadi item tengah pada date picker.
    @State private var selectedDate = Calendar.current.startOfDay(for: .now)
    @State private var isDatePickerPresented = false

    private var visibleDates: [Date] {
        (-2...2).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: selectedDate)
        }
    }

    private var selectedDateBinding: Binding<Date> {
        Binding(
            get: { selectedDate },
            set: { selectedDate = Calendar.current.startOfDay(for: $0) }
        )
    }
    
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
                Button(action: { isDatePickerPresented = true }) {
                    Image(systemName: "calendar")
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.05)))
                }
                .popover(isPresented: $isDatePickerPresented, arrowEdge: .top) {
                    VStack(spacing: 16) {
                        DatePicker(
                            "Select Date",
                            selection: selectedDateBinding,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .padding()

                        Button("Done") {
                            isDatePickerPresented = false
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom)
                    }
                    .frame(width: 340)
                    .presentationCompactAdaptation(.popover)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // --- FUNCTIONAL DATE PICKER ---
            HStack {
                Button(action: { moveSelectedDate(by: -1) }) { Image(systemName: "chevron.left") }
                
                HStack(spacing: 15) {
                    ForEach(visibleDates, id: \.self) { date in
                        DateItem(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate))
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedDate = Calendar.current.startOfDay(for: date)
                                }
                            }
                    }
                }
                .padding(.vertical, 5)
                
                Button(action: { moveSelectedDate(by: 1) }) { Image(systemName: "chevron.right") }
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

    private func moveSelectedDate(by days: Int) {
        withAnimation(.spring()) {
            selectedDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) ?? selectedDate
        }
    }

}


#Preview {
    TransactionsView()
}

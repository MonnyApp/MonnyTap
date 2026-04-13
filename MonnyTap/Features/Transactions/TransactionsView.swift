//
//  TransactionsView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

// tampilan slide
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
    @Query(sort: \Transaction.date, order: .reverse) private var transactions: [Transaction]

    // Tanggal aktif selalu menjadi item tengah pada date picker.
    @State private var selectedDate: Date
    @State private var isDatePickerPresented = false

    init(selectedDate: Date = Calendar.current.startOfDay(for: .now)) {
        _selectedDate = State(initialValue: Calendar.current.startOfDay(for: selectedDate))
    }

    private var visibleDates: [Date] {
        (-2...2).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: selectedDate)
        }
    }

    private var filteredTransactions: [Transaction] {
        transactions.filter { transaction in
            Calendar.current.isDate(transaction.date, inSameDayAs: selectedDate)
        }
    }

    private var selectedDateBinding: Binding<Date> {
        Binding(
            get: { selectedDate },
            set: {
                selectedDate = Calendar.current.startOfDay(for: $0)
                isDatePickerPresented = false
            }
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            // FUNCTIONAL DATE PICKER
            HStack {
                Button(action: { moveSelectedDate(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                }

                Spacer()

                HStack(spacing: 15) {
                    ForEach(visibleDates, id: \.self) { date in
                        DateItem(
                            date: date,
                            isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate)
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedDate = Calendar.current.startOfDay(for: date)
                            }
                        }
                    }
                }

                Spacer()

                Button(action: { moveSelectedDate(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)

            // TRANSACTION LIST
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    if filteredTransactions.isEmpty {
                        Text("No Transactions")
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                    } else {
                        ForEach(filteredTransactions) { transaction in
                            AllTransactionCard(transaction: transaction)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(white: 0.98).ignoresSafeArea())
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isDatePickerPresented = true }) {
                    Image(systemName: "calendar")
                        .padding(6)
                        
                }
                .popover(isPresented: $isDatePickerPresented, arrowEdge: .top) {
                    DatePicker(
                        "Select Date",
                        selection: selectedDateBinding,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .padding()
                    .frame(width: 340)
                    .presentationCompactAdaptation(.popover)
                }
            }
        }
    }

    private func moveSelectedDate(by days: Int) {
        withAnimation(.spring()) {
            selectedDate = Calendar.current.date(
                byAdding: .day, value: days, to: selectedDate
            ) ?? selectedDate
        }
    }
}

private struct TransactionsViewPreview: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [Transaction]

    var body: some View {
        NavigationStack {
            TransactionsView(selectedDate: MockData.transactions.first?.date ?? .now)
        }
        .onAppear {
            if transactions.isEmpty {
                for transaction in MockData.transactions {
                    modelContext.insert(transaction)
                }
            }
        }
    }
}

#Preview {
    TransactionsViewPreview()
        .modelContainer(for: Transaction.self, inMemory: true)
}

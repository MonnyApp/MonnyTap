//
//  ModalCategoryExpenseView.swift
//  MonnyTap
//
//  Created by Ibnu Taufick Ahraza on 07/04/26.
//

import SwiftUI

/// Layar modal yang memungkinkan pengguna memilih kategori untuk sebuah transaksi.
struct ModalCategoryExpenseView: View {
    /// Kategori yang saat ini dipilih, diikat (binding) dari parent view.
    @Binding var selectedCategory: Category?
    
    /// Callback opsional yang dieksekusi saat pengguna menekan tombol simpan.
    var onSave: ((Category?) -> Void)?
    
    @State private var viewModel = ModalCategoryExpenseViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // Konfigurasi grid dengan 3 kolom yang ukurannya fleksibel
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        // 1. Tambahkan NavigationStack agar Toolbar bisa muncul
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.categories) { category in
                        CategoryCell(
                            category: category,
                            isSelected: viewModel.isSelected(category)
                        )
                        .onTapGesture {
                            viewModel.select(category)
                        }
                    }
                }
                .padding()
            }
            // 2. Set judul navigasi (menggantikan Text "Choose Category" di HStack)
            .navigationTitle("Choose Category")
            .navigationBarTitleDisplayMode(.inline)
            // 3. Panggil variabel toolbar
            .toolbar {
                navigationToolbar
            }
        }
        .onAppear {
            viewModel.tempSelection = selectedCategory ?? .other
        }
    }
    
    // MARK: - Subviews
    
    /// Variabel terpisah untuk isi Toolbar (menggantikan headerView sebelumnya)
    @ToolbarContentBuilder
    private var navigationToolbar: some ToolbarContent {
        // Tombol Simpan (Kanan)
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                let newValue = viewModel.confirmSelection(currentSelection: selectedCategory)
                selectedCategory = newValue
                onSave?(newValue)
                dismiss()
            }) {
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(Color("blueactionbutton"))
                    .clipShape(Circle())
            }
        }
    }
}

// MARK: - Komponen UI Tambahan

/// Tampilan individual untuk setiap ikon kategori di dalam grid.
struct CategoryCell: View {
    let category: Category
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(category.color.opacity(0.6))
                    .frame(width: 80, height: 80)
                
                Image(systemName: category.icon)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(category.iconColor)
            }
            
            Text(category.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray6).opacity(0.3))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(category.rawValue)
    }
}

#Preview {
    @Previewable @State var selected: Category?
    return ModalCategoryExpenseView(selectedCategory: $selected) { _ in }
}

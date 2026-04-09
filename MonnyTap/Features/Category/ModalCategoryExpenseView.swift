//
//  ModalCategoryExpenseView.swift
//  MonnyTap
//
//  Created by Ibnu Taufick Ahraza on 07/04/26.
//

import SwiftUI

/// Layar modal yang memungkinkan pengguna memilih kategori untuk sebuah transaksi.
struct ModalCategoryExpenseView: View {
    /// Kategori yang saat ini dipilih, diikat (binding) dari parent view (misal: form tambah transaksi).
    @Binding var selectedCategory: Category?
    /// Callback opsional yang dieksekusi saat pengguna menekan tombol simpan.
    var onSave: ((Category?) -> Void)?
    
    @State private var viewModel = ModalCategoryExpenseViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    // Konfigurasi grid dengan 3 kolom yang ukurannya fleksibel membagi lebar layar.
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.categories) { category in
                        CategoryCell(
                            category: category,
                            isSelected: viewModel.isSelected(category)
                        )
                        .onTapGesture {
                            // Memperbarui pilihan sementara di ViewModel saat cell ditekan.
                            viewModel.select(category)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            // Saat modal muncul, pastikan tempSelection terisi.
            // Gunakan kategori yang sudah ada, atau paksa ke '.other' jika ini transaksi baru.
            viewModel.tempSelection = selectedCategory ?? .other
        }
    }
    
    // MARK: - Subviews
    
    /// Tampilan header bagian atas yang berisi tombol tutup, judul, dan tombol konfirmasi.
    private var headerView: some View {
        HStack {
            // Tombol Batal / Tutup
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
            Spacer()
            Text("Choose Category")
                .font(.headline)
            Spacer()
            // Tombol Simpan
            Button(action: {
                // Terapkan pilihan sementara ke variabel binding
                let newValue = viewModel.confirmSelection(currentSelection: selectedCategory)
                selectedCategory = newValue
                // Beri tahu parent view bahwa proses penyimpanan terjadi
                onSave?(newValue)
                dismiss()
            })
            {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}

// MARK: - Komponen UI Tambahan

/// Tampilan individual untuk setiap ikon kategori di dalam grid layar pemilihan kategori.
struct CategoryCell: View {
    /// Data kategori yang direpresentasikan oleh cell ini.
    let category: Category
    /// Menentukan apakah cell ini sedang dipilih untuk menampilkan efek visual aktif.
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
        // Berikan latar belakang biru tipis jika dipilih, atau abu-abu transparan jika tidak
        .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray6).opacity(0.3))
        .cornerRadius(20)
        .overlay(
            // Tambahkan garis tepi biru jika dipilih
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
        // Aksesibilitas: Menggabungkan gambar dan teks agar VoiceOver membacanya sebagai satu tombol utuh
        .accessibilityElement(children: .combine) // Mengelompokkan gambar dan teks menjadi satu
        .accessibilityAddTraits(.isButton)        // Memberitahu VoiceOver "This is a button you can tap"
        .accessibilityLabel(category.rawValue)    // Memberitahu VoiceOver untuk membaca "FnB" atau "Health"
        
    }
}

#Preview {
    @Previewable @State var selected: Category?
    return ModalCategoryExpenseView(selectedCategory: $selected) { _ in }
}

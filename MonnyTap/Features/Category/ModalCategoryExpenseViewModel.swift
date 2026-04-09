//
//  ModalCategoryExpenseViewModel.swift
//  MonnyTap
//
//  Created by Assistant on 09/04/26.
//

//
//  ModalCategoryExpenseViewModel.swift
//  MonnyTap
//
//  Created by Assistant on 09/04/26.
//

import Foundation

/// ViewModel yang menangani logika pemilihan kategori pada layar ModalCategoryExpenseView.
@Observable
final class ModalCategoryExpenseViewModel {
    /// Daftar seluruh kategori yang tersedia untuk ditampilkan di UI.
    var categories: [Category] = Category.allCases
    
    /// Menyimpan pilihan kategori pengguna secara sementara sebelum tombol simpan ditekan.
    var tempSelection: Category?
    
    
    init(initialSelection: Category? = nil) {
        self.tempSelection = initialSelection
    }
    
    // MARK: - Fungsi Seleksi
    // Catatan: Gunakan '// MARK: -' untuk memisahkan bagian kode agar rapi di minimap Xcode.
    
    func select(_ category: Category) {
        tempSelection = category
    }
    func isSelected(_ category: Category) -> Bool {
        tempSelection == category
    }
    /// Mengonfirmasi pilihan kategori saat ini dan mengembalikannya ke view induk.
    ///
    /// Fungsi ini akan mengecek apakah ada kategori baru yang dipilih (`tempSelection`).
    /// Jika tidak ada, fungsi akan mengembalikan kategori bawaan dari transaksi tersebut.
    ///
    /// - Parameter currentSelection: Kategori yang saat ini tersimpan di transaksi (jika sedang mode edit).
    /// - Returns: Kategori final yang akan disimpan ke dalam database.
    func confirmSelection(currentSelection: Category?) -> Category? {
        tempSelection ?? currentSelection
    }
    /// Mengosongkan pilihan sementara saat modal ditutup atau di-reset.
    func clear() {
        tempSelection = nil
    }
}

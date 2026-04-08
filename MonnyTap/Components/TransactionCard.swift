//
//  TransactionCard.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI

struct TransactionCard: View {
    var body: some View {
        HStack(spacing: 16) {

            VStack(spacing: 4) {
                ZStack {
                    Circle()
                        .fill(Color.yellowmonny)
                        .frame(width: 52, height: 52)
                    Image(systemName: "fork.knife")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                }
                Text("FnB")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Ayam Geprek Wani")
                    .font(.subheadline)
                Text("Rp 13.000")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(50)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    TransactionCard()
}

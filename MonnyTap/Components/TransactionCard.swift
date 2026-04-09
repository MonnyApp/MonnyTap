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
                        .frame(width: 35, height: 35)
                    Image(systemName: "fork.knife")
                        .foregroundColor(Color("yellowicon"))
                        .font(.system(size: 18))
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
                    .foregroundColor(Color.redexpense)
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 5)
        .background(Color(.systemBackground))
        .cornerRadius(50)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    TransactionCard()
}

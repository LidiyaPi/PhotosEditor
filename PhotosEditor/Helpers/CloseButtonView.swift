//
//  CloseButtonView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 14.09.2024.
//

import SwiftUI

struct CloseButton: View {
    
    let action: (() -> Void)
    
    var body: some View {
        VStack(alignment: .trailing, spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                Spacer()
                
                Button(action: action) {
                    Circle().overlay(
                        Text("X")
                            .font(.title)
                            .bold()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(.white)
                    )
                    .foregroundColor(.gray)
                }
                .frame(width: 40, height: 40, alignment: .center)
                .padding()
            }
            Spacer()
        }
    }
}

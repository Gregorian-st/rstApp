//
//  CategoryRowView.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI

struct CategoryRowView: View {
    
    var category: CategoryItem
    
    private let fontSize: CGFloat = 20
    
    var body: some View {
        HStack(alignment: .center) {
            Text(category.name)
                .font(.system(size: fontSize, design: .default))
                .foregroundColor(Color(.label))
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer()
            
            ZStack {
                if !category.color.isGradient {
                    Circle()
                        .foregroundColor(category.color.color)
                        .frame(height: 45)
                } else {
                    Circle()
                        .fill(category.color.gradient)
                        .frame(height: 45)
                }
                
                Text("\(category.count)")
                    .font(.system(size: fontSize, design: .default))
                    .foregroundColor(.white)
            }
            .padding(5)
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryRowView(category: CategoryItem(name: "Развлечения",
                                               type: "fun",
                                               icon: "rst-faces_happy",
                                               color: RstColor(colorName: "danger-10"),
                                               count: 9))
        .preferredColorScheme(.light)
        CategoryRowView(category: CategoryItem(name: "Развлечения",
                                               type: "fun",
                                               icon: "rst-faces_happy",
                                               color: RstColor(colorName: "g-15"),
                                               count: 9))
        .preferredColorScheme(.dark)
    }
}

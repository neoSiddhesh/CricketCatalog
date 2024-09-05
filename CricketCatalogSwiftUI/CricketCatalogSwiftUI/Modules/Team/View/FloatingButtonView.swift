//
//  FloatingButtonView.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

struct FloatingButtonView: View {
    
    @Binding var showBottomSheet: Bool
    
    var body: some View {
        VStack {
            Button {
                showBottomSheet.toggle()
            } label: {
                Image(ImageConstants.floatingImage.rawValue)
                    .padding()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(.skyBlue)
            }
            .clipShape(Circle())
            .padding(.trailing, 20)
            .padding(.bottom, 20)
            .shadow(color: Color(UIColor.lightGray), radius: 5, x: 0, y: 2)
        }
    }
}


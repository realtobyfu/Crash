//
//  RoundedViews.swift
//  Bullseye
//
//  Created by Tobias Fu on 12/30/23.
//

import SwiftUI

struct RoundedImageStroked: View {
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .font(.title)
            .foregroundColor(Color("TextColor"))
            .frame(width: 56, height: 56)
            .overlay(
                Circle()
                    .strokeBorder(Color("ButtonStrokeColor"), lineWidth: 2)
            )
    }
}

struct RoundedImageFilled: View {
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .font(.title)
            .foregroundColor(Color("ButtonFilledTextColor"))
            .frame(width: 56, height: 56)
            .background(
                Circle()
                    .fill(Color("ButtonFilledBackgroundColor"))
            )

    }
}

struct RoundedRectTextView: View {
    var text: String

    var body: some View {
        Text(text)
            .kerning(-0.2)
            .bold()
            .font(.title3)
            .frame(width: 120, height: 65)
            .foregroundColor(Color("TextColor"))
            .overlay(
                RoundedRectangle(cornerRadius: 21)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color("ButtonStrokeColor"))
            )
    }
}



#Preview {
    VStack(spacing: 10) {
        RoundedImageFilled(systemName: "arrow.counterclockwise")
        RoundedImageStroked(systemName: "list.dash")
        RoundedRectTextView(text: "100")
    }
}

#Preview {
    VStack(spacing: 10) {
        RoundedImageFilled(systemName: "arrow.counterclockwise")
        RoundedImageStroked(systemName: "list.dash")
        RoundedRectTextView(text: "100")
    }
    .preferredColorScheme(.dark)
}

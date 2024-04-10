//
//  TextViews.swift
//  Bullseye
//
//  Created by Tobias Fu on 12/30/23.
//

import SwiftUI

struct InstructionText: View {
    var text: String
    var body: some View {
        Text(text.uppercased())
          .bold()
          .multilineTextAlignment(.center)
          .lineSpacing(4.0)
          .font(.footnote)
          .kerning(2.0)
    }
    
}

struct LabelText: View {
    var text: String
    var body: some View {
        Text(text.uppercased())
            .kerning(1.5)
            .bold()
            .font(.caption)
            .foregroundColor(Color("TextColor"))
    }
}

struct BodyText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
}

struct ButtonText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .bold()
            .padding()
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
            .background(
                Color.accentColor
            )
            .foregroundColor(Color("ButtonFilledTextColor"))
    }
}


struct BigNumberText: View {
    var text: String
    var body: some View {
        Text(String(text))
          .kerning(1.0)
          .font(.largeTitle)
          .fontWeight(.black)
    }
}


#Preview {
    VStack{
        InstructionText(text: "The slider value is")
        BigNumberText(text: "999")
        LabelText(text: "Score")
        BodyText(text: "You scored 200 points\n")
        ButtonText(text: "Start new round")
    }
    .padding()
}


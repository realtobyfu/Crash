//
//  BackgroundView.swift
//  Bullseye
//
//  Created by Tobias Fu on 12/31/23.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var game: Game
        
    var body: some View {
        VStack {
            Spacer()
            ButtomView(game: $game)
        }
            .padding()
            .background(
                RingsView()
//                Color("BackagroundColor")
                    .ignoresSafeArea()
            )
    }

}

struct TopView: View {
    @Binding var game: Game
    var body: some View {
        HStack {
//            Button {
//                game.restart()
//            } label: {
//                RoundedImageFilled(systemName: "arrow.counterclockwise")
//            }
            
            Spacer()
            
            RoundedImageStroked(systemName: "list.dash")
        }
    }
}

struct RingsView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            ForEach(1..<6) { ring in
                let opacity = colorScheme == .dark ? 0.1 : 0.3
                let size = CGFloat(ring * 100)
                Circle()
                    .stroke(lineWidth: 20)
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [Color("RingsColor").opacity(opacity * 0.8), Color("RingsColor").opacity(0)]), center: .center, startRadius: 100, endRadius: 300)
                    )
                    .frame(width: size, height: size)
            }
        }
    }
}


struct NumberView: View {
    var title: String
    var text: String
    
    var body: some View {
        VStack(spacing: 5) {
            LabelText(text: title)
            RoundedRectTextView(text: text)
        }
    }
    
}

struct ButtomView: View {
    @Binding var game: Game
    var body: some View {
        HStack {
            NumberView(title: "total coins".uppercased(), text: String(game.totalTokens))
//            Spacer()
//            NumberView(title: "Round".uppercased(), text: String("1"))
        }
    }
}



#Preview {
    BackgroundView(game: .constant(Game()))
    
}

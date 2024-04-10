//
//  Shapes.swift
//  Bullseye
//
//  Created by Tobias Fu on 12/30/23.
//

import SwiftUI

struct Shapes: View {
    var body: some View {
        VStack{
            Circle()
//                .inset(by: 10)
                .strokeBorder(Color.blue, lineWidth: 20)
//                .fill(Color.blue)
                .frame(width: 200.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                .background(Color.green)
            
            RoundedRectangle(cornerRadius: 50)
//                .fill(Color.blue)
                .strokeBorder(Color.white, lineWidth: 20)
                .frame(width: 200.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)

            Capsule()
                .fill(Color.blue)
                .frame(width: 200.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)

            Ellipse()
                .fill(Color.blue)
                .frame(width: 200.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)

        }
    }
}

#Preview {
    Shapes()
}

//
//  ContentView.swift
//  spotify1
//
//  Created by Irina Shakhmaykina on 9/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var length = 10.0
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "arrow.down").foregroundColor(.white)
                Spacer()
                Text("my playlist").foregroundColor(.white)
                Spacer()
                Image(systemName: "ellipsis").foregroundColor(.white)
            }
            Spacer()
            Image("astro")
                .resizable()
                .scaledToFit()
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("ASTROTHUNDER")
                        .foregroundColor(.white)
                    HStack{
                        Image(systemName: "e.square.fill")
                            .foregroundColor(.gray)
                        Text("Travis Scott")
                            .foregroundColor(.gray)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                Image(systemName: "heart").font(.system(size: 26))
                    .foregroundColor(.white)
            }
            Slider(
                value: $length,
                in: 0...100)
            .accentColor(.black)
            HStack{
                Image(systemName: "shuffle").foregroundColor(.green)
                    .font(.system(size: 30))
                Spacer()
                Image(systemName: "arrow.left.to.line").foregroundColor(.white)
                    .font(.system(size: 40))
                Spacer()
                Image(systemName: "pause.circle.fill").foregroundColor(.white)
                    .font(.system(size: 80))
                Spacer()
                Image(systemName: "arrow.right.to.line").foregroundColor(.white)
                    .font(.system(size: 40))
                Spacer()
                Image(systemName: "repeat").foregroundColor(.green)
                    .font(.system(size: 30))
            }
            HStack{
                Image(systemName: "hifispeaker.2").foregroundColor(.white)
                    .font(.system(size: 20))
                Spacer()
                Image(systemName: "square.and.arrow.up").foregroundColor(.white)
                    .font(.system(size: 20))
                Image(systemName: "line.3.horizontal").foregroundColor(.white)
                    .font(.system(size: 20))
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, Color(red: 0.035, green: 0.337, blue: 0.631)]), startPoint: .top, endPoint: .bottom))
    }
}
#Preview {
    ContentView()
}

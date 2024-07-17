//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daren Darnell on 7/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: reshuffle)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number : Int) {
        if(number == correctAnswer) {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score = 0
        }
        
        showingScore = true
    }
    
    func reshuffle() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

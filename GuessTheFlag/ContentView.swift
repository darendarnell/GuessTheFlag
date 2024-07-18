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
    
    @State private var showingGameOver = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var questionCount = 0
    
    @State private var highScore = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("High Score: \(highScore)/8")
                    .foregroundStyle(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                VStack {
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
                        .padding(5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 30))
                Text("Score: \(score)/\(questionCount)")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: reshuffle)
        } message: {
            Text("Current score is \(score)")
        }
        .alert("Game Over!", isPresented: $showingGameOver) {
            Button("New Game", action: newGame)
        } message: {
            Text("You scored \(score)/8")
        }
    }
    
    func flagTapped(_ number : Int) {
        if(number == correctAnswer) {
            scoreTitle = "Correct! Great Job!"
            score += 1
            questionCount += 1
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
            questionCount += 1
            // score = 0
        }
        
        if(questionCount == 8) {
            showingGameOver = true
        }
        else {
            showingScore = true
        }
    }
    
    func reshuffle() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func newGame() {
        score = 0
        questionCount = 0
        reshuffle()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Nwachukwu on 16/06/2024.
//

import SwiftUI

struct ContentView: View {
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var totalScore = 0
	@State private var questionsAnswered = 0
	
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
	
	@State private var correctAnswer = Int.random(in: 0...2)
	
    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			VStack(spacing: 30) {
				VStack {
					Text("Tap the flag of")
						.font(.subheadline.weight(.heavy))
					
					Text(countries[correctAnswer])
						.font(.largeTitle.weight(.semibold))
				}
				.foregroundStyle(.white)
				
				ForEach(0..<3) { number in
					Button {
						flagTapped(number)
					} label: {
						Image(countries[number])
							.clipShape(Capsule())
							.shadow(radius: 5)
					}
				}
			}
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text("Your score is \(totalScore)/\(questionsAnswered)")
		}
    }
	
	func flagTapped(_ number: Int) {
		questionsAnswered += 1
		
		if number == correctAnswer {
			scoreTitle = "Correct"
			totalScore += 1
		} else {
			scoreTitle = "Wrong"
		}
		
		showingScore = true
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

#Preview {
    ContentView()
}

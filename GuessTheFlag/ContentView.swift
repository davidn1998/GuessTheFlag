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
			RadialGradient(stops: [
				.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
				.init(color: Color(red: 0.76, green: 0.15, blue: 0.26 ), location: 0.3)
			], center: .top, startRadius: 200, endRadius: 700)
				.ignoresSafeArea()
			
			VStack {
				Spacer()
				
				Text("Guess the Flag")
					.font(.largeTitle.bold())
					.foregroundStyle(.white)
				
				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of")
							.font(.subheadline.weight(.heavy))
							.foregroundStyle(.secondary)
						
						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.semibold))
					}
					
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
				.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
				Spacer()
				
				Text("Score: \(totalScore)/\(questionsAnswered)")
					.foregroundStyle(.white)
					.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
				
				Spacer()
			}
			.padding()
			
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

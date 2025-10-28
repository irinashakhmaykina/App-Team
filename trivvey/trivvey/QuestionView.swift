//
//  QuestionView.swift
//  trivvey
//
//  Created by Irina Shakhmaykina on 10/27/25.
//

import SwiftUI

struct QuestionView: View{
    let question: Question
    @State private var result: String = ""
    @State private var currentIndex = 0
    @State private var questions = ""
    var body: some View{
        VStack{
            Text(question.question)
                .padding()
                .frame(width: 380, height: 100)
                .background(Color(red: 1.000, green: 0.702, blue: 0.776))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.984, green: 0.435, blue: 0.573), lineWidth: 2))
                .multilineTextAlignment(.center)
                .padding()
            HStack{
                Button(action: { checkAnswer("A") }) {
                    Text("A. \(question.A)")
                        .frame(width: 150, height: 100)
                        .background(Color(red: 1.000, green: 0.898, blue: 0.925))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 1.000, green: 0.761, blue: 0.820), lineWidth: 2))
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: { checkAnswer("B") }) {
                    Text("B. \(question.B)")
                        .frame(width: 150, height: 100)
                        .background(Color(red: 1.000, green: 0.898, blue: 0.925))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 1.000, green: 0.761, blue: 0.820), lineWidth: 2))
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                
            }
            .foregroundStyle(.black)
            
            HStack{
                Button(action: { checkAnswer("C") }) {
                    Text("C. \(question.C)")
                        .frame(width: 150, height: 100)
                        .background(Color(red: 1.000, green: 0.898, blue: 0.925))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 1.000, green: 0.761, blue: 0.820), lineWidth: 2))
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: { checkAnswer("D") }) {
                    Text("D. \(question.D)")
                        .frame(width: 150, height: 100)
                        .background(Color(red: 1.000, green: 0.898, blue: 0.925))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 1.000, green: 0.761, blue: 0.820), lineWidth: 2))
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                
                    
                    
            }
            .foregroundStyle(.black)
            .padding()
            Spacer()
            Text(result).font(.title)
            Spacer()
            Button("Next Question"){
                nextQuestion()
            }
        }
        
    }
    func checkAnswer(_ selected: String) {
        if selected == question.answer {
            result = "Correct!"
        } else {
            result = "Incorrect!"
            
        }
    }
    func nextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
}


#Preview{
    QuestionView(
            question: Question(
                id: UUID(),
                question: "A flashing red traffic light signifies that a driver should do",
                A: "stop",
                B: "speed up",
                C: "proceed with caution",
                D: "honk the horn",
                answer: "A"
            )
        )
}

//
//  ContentView.swift
//  trivvey
//
//  Created by Irina Shakhmaykina on 10/27/25.
//

import SwiftUI

struct Question: Identifiable, Codable{
    var id = UUID()
    let question: String
    let A: String
    let B: String
    let C: String
    let D: String
    let answer: String
    
    private enum CodingKeys: String, CodingKey{
        case question, A, B, C, D, answer
    }
}

struct ContentView: View {
        // store questions
    @State private var questions: [Question] = []
    
    var body: some View {
        NavigationStack {
            List(questions) {
                q in NavigationLink(q.question){
                    QuestionView(question: q)
                }
            }
            // Add navigationTitle
            .navigationTitle("Trivvey")
            .toolbar{
                Button("Shuffle"){
                    questions.shuffle()
                }
            }
            
        }
        .onAppear {
            let url: URL = Bundle.main.url(forResource: "questions", withExtension: "json")!
            let jsonData = try! Data(contentsOf: url)
            let decodedData: [Question] = try! JSONDecoder().decode([Question].self, from: jsonData)
            questions = decodedData
  
        }
    }
}

#Preview {
    ContentView()
}

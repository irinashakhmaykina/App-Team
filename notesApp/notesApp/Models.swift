//
//  Models.swift
//  notesApp
//
//  Created by Irina Shakhmaykina on 10/13/25.
//

import SwiftUI

struct Reminder: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct RemindersPage: Identifiable {
    var id: UUID = UUID()
    var title: String
    var items: [Reminder]
    var color: Color
}

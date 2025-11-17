//
//  Note.swift
//  new notes
//
//  Created by Monika Suresh Ilamkar on 14/11/25.
//

import Foundation
import SwiftData

@Model
final class Note {
    var id: UUID
    var title: String
    var content: String
    var fontName: String
    var fontSize: Double
    var timestamp: Date

    init(
        id: UUID = UUID(),
        title: String = "",
        content: String = "",
        fontName: String = "System",
        fontSize: Double = 16,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.fontName = fontName
        self.fontSize = fontSize
        self.timestamp = timestamp
    }
}

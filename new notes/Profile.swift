//
//  Profile.swift
//  new notes
//
//  Created by Monika Suresh Ilamkar on 14/11/25.
//

import Foundation
import SwiftData

@Model
final class Profile {
    var id: UUID
    var name: String
    var bio: String
    var imageData: Data?

    init(
        id: UUID = UUID(),
        name: String = "",
        bio: String = "",
        imageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.bio = bio
        self.imageData = imageData
    }
}


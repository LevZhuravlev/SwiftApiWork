//
//  Post.swift
//  SwiftApiWork
//
//  Created by Журавлев Лев on 03.11.2023.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


//
//  PRModel.swift
//  itau
//
//  Created by André Lucas on 14/09/21.
//

import Foundation

// MARK: - PRModel
struct PRModelElement: Codable {
    let title: String?
    let user: User?
    let createdAt: String?
    let body: String?
//    let repo: Repo?

    enum CodingKeys: String, CodingKey {
        case title, user
        case createdAt = "created_at"
        case body
    }
}

// MARK: - User
struct User: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}

typealias PRModel = [PRModelElement]

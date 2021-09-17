//
//  JavaPopModel.swift
//  itau
//
//  Created by André Lucas on 13/09/21.
//

import Foundation

// MARK: - JavaPopModel
struct JavaPopModel: Codable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let id: Int?
    let name, fullName: String?
    let owner: Owner?
    let itemDescription: String?
    let stargazersCount, forks: Int?

    enum CodingKeys: String, CodingKey {
        case id,name
        case fullName = "full_name"
        case owner
        case itemDescription = "description"
        case stargazersCount = "stargazers_count"
        case forks
    }
}

// MARK: - Owner
struct Owner: Codable {
    let avatarURL: String?
    let userLogin: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case userLogin = "login"
    }
}




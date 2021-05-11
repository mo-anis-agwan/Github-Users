//
//  UserModel.swift
//  Testing-Project
//
//  Created by Anis on 10/05/21.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let avatar_url: String
    let html_url: String
    let repos_url: String
    let type: String
    let site_admin: Bool
}

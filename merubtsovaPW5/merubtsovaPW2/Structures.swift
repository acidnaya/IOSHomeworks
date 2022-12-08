//
//  Structures.swift
//  merubtsovaPW2
//
//  Created by Maria Rubtsova on 09.12.2022.
//

import Foundation

struct APIResponse: Codable{
	let articles: [Article]
}

struct Article: Codable {
	let source: Source
	let title: String
	let description: String?
	let url: String?
	let urlToImage: String?
	let publishedAt: String
	let content: String?
}

struct Source: Codable {
	let id: String?
	let name: String
}

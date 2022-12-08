//
//  NewsApi.swift
//  merubtsovaPW2
//
//  Created by Maria Rubtsova on 08.12.2022.
//

import Foundation

final class ApiService {
	static let shared = ApiService()
	
	private let urlSession: URLSession = URLSession.shared
	//private let apiKey: String = "117c8cac7aa14e529adda6aa3d60fc41"
	
	
	func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
		let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=117c8cac7aa14e529adda6aa3d60fc41")!
		let task = urlSession.dataTask(with: url) { data, _, error in
			if error != nil {
				completion(.failure(error!))
			}
			else if data != nil {
				do {
					let result = try JSONDecoder().decode(APIResponse.self, from: data!)
					completion(.success(result.articles))
				}
				catch {
					completion(.failure(error))
				}
			}
		}
		task.resume()
	}
}

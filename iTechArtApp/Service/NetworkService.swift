//
//  NetworkManager.swift
//  iTechArtApp
//
//  Created by Tsimafei Zykau on 11/24/20.
//

import Foundation
import UIKit

class NetworkService {
    
    var isPaginating = false
    var pageNumber = 0
    private var url: URL {
        return URL(string: "https://api.github.com/events?page=\(pageNumber)")!
    }
    
    func fetchEvents(paginating: Bool = false, completion: @escaping ([Event]?, Error?) -> Void) {
        if paginating {
            isPaginating = true
            pageNumber += 1
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let dataArray = try decoder.decode([Event].self, from: data)
                    if paginating {
                        self.isPaginating = false
                    }
                    completion(dataArray, error)
                }
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            completion(image)
        }.resume()
    }
    
}

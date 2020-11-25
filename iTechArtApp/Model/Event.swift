//
//  Event.swift
//  iTechArtApp
//
//  Created by Tsimafei Zykau on 11/24/20.
//

import Foundation
import UIKit

struct Event: Decodable {
    var authorName: String
    var avatarUrl: String
    var date: Date
    var repositoryName: String
    
    var avatarImage: UIImage?
    var stringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, d MMM YYYY"
        return dateFormatter.string(from: self.date)
    }
    
    enum CodingKeys: String, CodingKey {
        case actor
        case repo
        case date = "created_at"
    }
    enum ActorCodingKeys: String, CodingKey {
        case authorName = "display_login"
        case avatarUrl = "avatar_url"
    }
    enum RepoCodingKeys: String, CodingKey {
        case repositoryName = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        
        let actorContainer = try container.nestedContainer(keyedBy: ActorCodingKeys.self, forKey: .actor)
        self.authorName = try actorContainer.decode(String.self, forKey: .authorName)
        self.avatarUrl = try actorContainer.decode(String.self, forKey: .avatarUrl)
        
        let repoContainer = try container.nestedContainer(keyedBy: RepoCodingKeys.self, forKey: .repo)
        self.repositoryName = try repoContainer.decode(String.self, forKey: .repositoryName)
    }
}

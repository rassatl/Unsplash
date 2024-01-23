//
//  UnsplashTopic.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/24/24.
//

import Foundation

struct UnsplashTopic: Codable, Identifiable {
    let id: String
    let slug: String
    let cover_photo : UnsplashPhoto
}

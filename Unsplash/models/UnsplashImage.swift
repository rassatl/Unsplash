//
//  UnsplashImage.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/24/24.
//

import SwiftUI

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    let user: User
    let urls: UnsplashPhotoUrls
}

struct User: Codable {
    let name: String
    let profile_image: ProfileImage
}

struct ProfileImage: Codable {
    let large: String
    let medium: String
    let small: String
}
struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

enum ScreenResolution : String, CaseIterable {
    case small = "small"
    case regular = "regular"
    case full = "full"
    
    func getPhotoResolution(photo : UnsplashPhoto) -> String {
        switch self {
            case .small : return photo.urls.small
            case .regular : return photo.urls.regular
            case .full : return photo.urls.full
        }
    }
}

let defaultUnsplashImage = """
{
        "id": "207NEuFvjlg",
        "slug": "a-person-standing-on-top-of-a-cliff-207NEuFvjlg",
        "urls": {
            "raw": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?ixid=M3w1NTc1Njh8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTUxOHw&ixlib=rb-4.0.3",
            "full": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NTc1Njh8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTUxOHw&ixlib=rb-4.0.3&q=85",
            "regular": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NTc1Njh8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTUxOHw&ixlib=rb-4.0.3&q=80&w=1080",
            "small": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NTc1Njh8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTUxOHw&ixlib=rb-4.0.3&q=80&w=400",
            "thumb": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NTc1Njh8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTUxOHw&ixlib=rb-4.0.3&q=80&w=200",
            "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1682685794761-c8e7b2347702"
        },
        "author" : { "name" : anne_kristin_euba }
}
"""

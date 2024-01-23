//
//  ContentView.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/23/24.
//

import SwiftUI

let imageURLs: [String] = [
    "https://images.unsplash.com/photo-1683009427666-340595e57e43?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MXwxfGFsbHwxfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1563473213013-de2a0133c100?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwyfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1490349368154-73de9c9bc37c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwzfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1495379572396-5f27a279ee91?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw0fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1560850038-f95de6e715b3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw1fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MXwxfGFsbHw2fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1547327132-5d20850c62b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw3fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1492724724894-7464c27d0ceb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw4fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1475694867812-f82b8696d610?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw5fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1558816280-dee9521ff364?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwxMHx8fHx8fDF8fDE3MDM3NTk1NTF8&ixlib=rb-4.0.3&q=80&w=1080",
    "https://images.unsplash.com/photo-1499988921418-b7df40ff03f9?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb",
    "https://images.unsplash.com/photo-1526994636733-4c05e8e063fb?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb",
    "https://images.unsplash.com/photo-1539593395743-7da5ee10ff07?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb",
    "https://images.unsplash.com/photo-1448375240586-882707db888b?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb",
]
// création d'une extention pour les composants images
extension Image {
    //création d'une fonction qui retourne un composant View
    func centerCropped() -> some View {
        //utilise une @frozen structure GeometryReader qui permet de nous dire qu'elle taille les images vont avoir pour que l'on puisse avoir 2 colonnes sans déformé les images
        GeometryReader { geo in
            // l'image actuelle
            self
            // Définit le mode par lequel SwiftUI redimensionne une image pour qu'elle s'adapte à son espace.
            .resizable()
            // Met à l'échelle cette vue pour remplir son parent.
            .scaledToFill()
            // Place cette vue à l'intérieur d'une frame invisible de la taille spécifiée.
            .frame(width: geo.size.width, height: geo.size.height)
            // Attache cette vue à son cadre rectangulaire de délimitation
            .clipped()
        }
    }
}
struct ContentView: View {
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                    ForEach(imageURLs, id: \.self) { item in
                        AsyncImage(url: URL(string: item)) { image in
                            image.centerCropped()
                                .cornerRadius(12)
                                .frame(height: 150)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                })
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
            .padding()
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    ContentView()
}

struct UnsplashPhoto: Codable, Identifiable {
    let id, slug: String
    let urls: UnsplashPhotoUrls
    let user: User
}

struct UnsplashPhotoUrls: Codable {
    let raw, full, regular, small, thumb: String
}

struct User: Codable {
    let name: String
}

let CodingKeys = """
{
    "id": "207NEuFvjlg",
    "slug": "a-person-standing-on-top-of-a-cliff-207NEuFvjlg",
    "urls": {
        "raw": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?ixid=M3w1NTc1NzB8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTM4NHw&ixlib=rb-4.0.3",
        "full": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NTc1NzB8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTM4NHw&ixlib=rb-4.0.3&q=85",
        "regular": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NTc1NzB8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTM4NHw&ixlib=rb-4.0.3&q=80&w=1080",
        "small": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NTc1NzB8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTM4NHw&ixlib=rb-4.0.3&q=80&w=400",
        "thumb": "https://images.unsplash.com/photo-1682685794761-c8e7b2347702?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NTc1NzB8MXwxfGFsbHwxfHx8fHx8Mnx8MTcwNjAxOTM4NHw&ixlib=rb-4.0.3&q=80&w=200"
    },
    "user": {
        "name": "NEOM"
    }
}
"""

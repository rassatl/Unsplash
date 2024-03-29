//
//  DetailPhoto.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/24/24.
//

import Foundation

import SwiftUI

struct DetailPhoto: View {
    let photo : UnsplashPhoto
    @State var screenResolution : ScreenResolution = ScreenResolution.small
    
    var body: some View {
        NavigationStack{
            VStack{
                AsyncImage(url: URL(string: photo.user.profile_image.large)){ image in
                    image
                        .centerCropped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
                Picker("Type", selection: $screenResolution) {
                    ForEach(ScreenResolution.allCases, id: \.self) { resolution in
                        Text(resolution.rawValue)
                    }
                }
                .pickerStyle(PalettePickerStyle())
                AsyncImage(url: URL(string: screenResolution.getPhotoResolution(photo: photo))!){ image in
                    image
                        .centerCropped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    ProgressView()
                }
            }
            .navigationBarTitle("Une image de @\(photo.user.name)")
        }
    }
}

#Preview {
    DetailPhoto(photo: UnsplashPhoto(id: "img",slug: "slug_image",user: User(name: "hop", profile_image: ProfileImage(large: "String", medium: "String", small: "String")),urls: UnsplashPhotoUrls(raw: "raw",full: "full",regular: "regular",small: "small",thumb: "thumb")))
}

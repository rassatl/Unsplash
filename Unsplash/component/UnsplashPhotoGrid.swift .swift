//
//  UnsplashPhotoGrid.swift .swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/24/24.
//

import SwiftUI

struct UnsplashPhotoGrid: View {
    @State var showDetailPhotoView = false
    @State var selectedImage : UnsplashPhoto? = nil
    
    let title : String
    let unsplashPhotos : [UnsplashPhoto]?
    var body: some View {
        HStack{
            Spacer()
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible(minimum: 150)),GridItem(.flexible(minimum: 150))], spacing: 8, content: {
                    if let images = unsplashPhotos {
                        ForEach(images, id: \.id) { image in
                            AsyncImage(url: URL(string: image.urls.small)!){ image in
                                image
                                    .centerCropped()
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height:150)
                            .onTapGesture {
                                selectedImage = image
                            }
                        }
                    }
                    else{
                        ForEach(1...12, id: \.self) { _ in
                            Rectangle()
                                .fill(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(height:150)
                        }
                    }
                })
                .onReceive(selectedImage.publisher, perform: { _ in
                    showDetailPhotoView.toggle()
                })
                .sheet(isPresented: $showDetailPhotoView) {
                    if let photo = selectedImage {
                        DetailPhoto(photo: photo)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer()
        }
        .navigationTitle("\(title)")
    }
}

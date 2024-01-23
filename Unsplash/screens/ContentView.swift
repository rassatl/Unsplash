//
//  ContentView.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/23/24.
//
import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            // permet à l'image à être redimensionnable en height et en width
            .resizable()
            // permet à l'image de prendre toutes l'espace disponible
            .scaledToFill()
            // définie la taille de l'image
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct ContentView: View {
    @StateObject var feedState : FeedState = FeedState()
    @State var showTopicPhotosView = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal){
                LazyHGrid(rows: [GridItem(.flexible(minimum: 150))], spacing: 13, content: {
                    Spacer().frame(width: 5)
                    if let topics = feedState.topics {
                        ForEach(topics, id: \.id){ topic in
                            NavigationLink{
                                TopicPhotosView(topic: topic).environmentObject(feedState)
                            } label: {
                                VStack{
                                    AsyncImage(url: URL(string: topic.cover_photo.urls.small)!){ image in
                                        image
                                            .centerCropped()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 110, height: 70)
                                    Text(topic.slug)
                                }
                            }
                        }
                    }
                    else{
                        ForEach(1...12, id: \.self) { _ in
                            VStack{
                                Rectangle()
                                    .fill(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .frame(width: 110, height: 70)
                                Text("placholder")
                            }.redacted(reason: .placeholder)
                        }
                    }
                    Spacer().frame(width: 5)
                })
            }
            .frame(height: 140)
            UnsplashPhotoGrid(title: "Feed", unsplashPhotos: feedState.homeFeed)
            Button(action: {
                Task {
                    await feedState.fetchTopics()
                    await feedState.fetchHomeFeed()
                }
            }) {
                Text("Load Data")
            }
        }
    }
}

#Preview {
    ContentView()
}

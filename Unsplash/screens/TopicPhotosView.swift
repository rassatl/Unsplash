//
//  TopicPhotosView.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/24/24.
//

import SwiftUI

struct TopicPhotosView: View {
    let topic : UnsplashTopic
    @EnvironmentObject var feedState : FeedState
    
    var body: some View {
        UnsplashPhotoGrid(title: "\(topic.slug)", unsplashPhotos: feedState.topicPhotos)
        Button(action: {
            Task {
                await feedState.fetchTopicPhoto(topic: topic)
            }
        }) {
            Text("Load Topic Pictures")
        }
    }
}

#Preview {
    TopicPhotosView(topic: UnsplashTopic(id: "topic",slug: "slug_topic",cover_photo: UnsplashPhoto(id: "img",slug: "slug_image",user: User(name: "hop"),urls: UnsplashPhotoUrls(raw: "raw",full: "full",regular: "regular",small: "small",thumb: "thumb")))
    )
}

//
//  FeedState.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/24/24.
//

import Foundation

class FeedState : ObservableObject {
    let unsplashAPI : UnsplashAPI = UnsplashAPI()
    
    @Published var homeFeed : [UnsplashPhoto]?
    @Published var topics : [UnsplashTopic]?
    @Published var topicPhotos : [UnsplashPhoto]?

    func fetchHomeFeed() async {
        guard let url = unsplashAPI.feedUrl() else {
            return
        }
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            await MainActor.run{ homeFeed = deserializedData }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchTopics() async {
        guard let url = unsplashAPI.getAllTopics() else {
            return
        }
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashTopic].self, from: data)
            await MainActor.run{ topics = deserializedData }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchTopicPhoto(topic : UnsplashTopic) async {
        guard let url = unsplashAPI.getTopicPhotos(topic: topic) else {
            return
        }
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            await MainActor.run{ topicPhotos = deserializedData }
        } catch {
            print("Error: \(error)")
        }
    }
}

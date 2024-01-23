//
//  UnsplashAPI.swift
//  Unsplash
//
//  Created by Lou RASSAT on 1/23/24.
//

import Foundation

enum NetworkError: Error {
    case baseUrlError
    case invalidUrl
}

struct UnsplashAPI{
    // Construit un objet URLComponents avec la base de l'API Unsplash
    // Et un query item "client_id" avec la clé d'API retrouvé depuis PListManager
    func unsplashApiBaseUrl() throws -> URLComponents {
        guard var baseUrl = URLComponents(string:"https://api.unsplash.com/") else {
            throw NetworkError.baseUrlError
        }
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId))
        baseUrl.queryItems = queryItems
        
        return baseUrl
    }
    
    // Par défaut orderBy = "popular" et perPage = 10 -> Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
    func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
        do {
            var urlComponents = try unsplashApiBaseUrl()
            urlComponents.path.append("photos")
            urlComponents.queryItems?.append(URLQueryItem(name: "order_by", value: orderBy))
            urlComponents.queryItems?.append(URLQueryItem(name: "per_page", value: "\(perPage)"))
            
            guard let url = urlComponents.url else {
                throw NetworkError.invalidUrl
            }
            
            return url
        } catch {
            print("Error constructing feed URL: \(error)")
            return nil
        }
    }
    
    func getAllTopics(orderBy: String = "popular", perPage: Int = 10) -> URL? {
        do {
            var urlComponents = try unsplashApiBaseUrl()
            urlComponents.path.append("topics")
            urlComponents.queryItems?.append(URLQueryItem(name: "order_by", value: orderBy))
            urlComponents.queryItems?.append(URLQueryItem(name: "per_page", value: "\(perPage)"))
            
            guard let url = urlComponents.url else {
                throw NetworkError.invalidUrl
            }
            
            return url
        } catch {
            print("Error constructing feed URL: \(error)")
            return nil
        }
    }
    
    func getTopicPhotos(topic : UnsplashTopic, orderBy: String = "popular", perPage: Int = 10) -> URL? {
        do {
            var urlComponents = try unsplashApiBaseUrl()
            urlComponents.path.append("topics/\(topic.id)/photos")
            urlComponents.queryItems?.append(URLQueryItem(name: "order_by", value: orderBy))
            urlComponents.queryItems?.append(URLQueryItem(name: "per_page", value: "\(perPage)"))
            guard let url = urlComponents.url else {
                throw NetworkError.invalidUrl
            }
            
            return url
        } catch {
            print("Error constructing feed URL: \(error)")
            return nil
        }
    }
}

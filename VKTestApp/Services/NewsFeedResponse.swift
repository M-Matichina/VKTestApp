//
//  NewsFeedResponse.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/17/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation

// Decodable - преобразаует JSON в читаемый формат

// MARK: Получаем декодируемый ответ

struct NewsFeedResponseWrapped: Decodable {
    let response: NewsFeedResponse
}

struct NewsFeedResponse: Decodable {
    var items: [NewsFeedItem] // Массив новостей для текущего пользователя
    var nextFrom: String?
}

struct NewsFeedItem: Decodable {
    let sourceId: Int 
    let text: String?
    let attachments: [Attachment]?
    
    var postType: String {
        get {
            return sourceId >= 0 ? "Пост пользователя" : "Пост группы"
        }
    }
}

struct Attachment: Decodable {
    let type: String?
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [SizePhoto]?
}

struct SizePhoto: Decodable {
    let type: String
    let url: String
}


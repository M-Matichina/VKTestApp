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
    let items: [NewsFeedItem] // Массив новостей для текущего пользователя
    
}

struct NewsFeedItem: Decodable {
    let date: Double
    let text: String?
    let attachments: [Attachment]?
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

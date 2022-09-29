//
//  Model.swift
//  TetGAPSI
//
//  Created by Sebastian TC on 28/09/22.
//

import Foundation

struct ResponseModel: Codable {
    var item: ItemModel
}

struct ItemModel: Codable {
    var props: Props
}

struct Props: Codable {
    var pageProps: PageProps
}

struct PageProps: Codable {
    var initialData: InitialData
}

struct InitialData: Codable {
    var searchResult: SearchResult
}

struct SearchResult: Codable {
    var title: String
    var  itemStacks: [ItemStacks]
}

struct ItemStacks: Codable {
    var items: [Item]
}

struct Item: Codable, Hashable {
    var image: String
    var name: String
    var price: Int
}

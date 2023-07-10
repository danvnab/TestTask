//
//  BooksScreenModel.swift
//  TestTask
//
//  Created by Danil Velanskiy on 09.07.2023.
//

import Foundation
import UIKit
import RealmSwift

// MARK: - Welcome
struct BookMainModel: Codable {
    var results: BooksList

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from realmModel: RealmBookMainModel) {
        self.results = BooksList(from: realmModel.results ?? RealmBooksList())
    }
}

// MARK: - Results
struct BooksList: Codable {
    let listName, listNameEncoded, bestsellersDate, publishedDate: String
    let publishedDateDescription, nextPublishedDate, previousPublishedDate, displayName: String
    var books: [Book]

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case nextPublishedDate = "next_published_date"
        case previousPublishedDate = "previous_published_date"
        case displayName = "display_name"
        case books
    }

    init(from realmModel: RealmBooksList) {
        self.listName = realmModel.listName
        self.listNameEncoded = realmModel.listNameEncoded
        self.bestsellersDate = realmModel.bestsellersDate
        self.publishedDate = realmModel.publishedDate
        self.publishedDateDescription = realmModel.publishedDateDescription
        self.nextPublishedDate = realmModel.nextPublishedDate
        self.previousPublishedDate = realmModel.previousPublishedDate
        self.displayName = realmModel.displayName
        self.books = realmModel.books.map { Book(from: $0) }
    }
}

// MARK: - Book
struct Book: Codable {
    var image: UIImage?
    let rank: Int
    let publisher, description: String
    let title, author: String
    let contributorNote: String
    let bookImage: String
    let buyLinks: [BuyLink]

    enum CodingKeys: String, CodingKey {
        case rank
        case publisher, description, title, author
        case contributorNote = "contributor_note"
        case bookImage = "book_image"
        case buyLinks = "buy_links"
    }

    init(from realmModel: RealmBook) {
        self.image = UIImage(data: realmModel.image) ?? .remove
        self.rank = realmModel.rank
        self.publisher = realmModel.publisher
        self.description = realmModel.bookDescription
        self.title = realmModel.title
        self.author = realmModel.author
        self.contributorNote = realmModel.contributorNote
        self.bookImage = "" // realmModel doesn't contain a bookImage field
        self.buyLinks = realmModel.buyLinks.map { BuyLink(from: $0) }
    }
}

// MARK: - BuyLink
struct BuyLink: Codable {
    let name: shopsName
    let url: String

    init(from realmModel: RealmBuyLink) {
        self.name = shopsName(rawValue: realmModel.name) ?? .amazon
        self.url = realmModel.url
    }
}


enum shopsName: String, Codable {
    case amazon = "Amazon"
    case appleBooks = "Apple Books"
    case barnesAndNoble = "Barnes and Noble"
    case booksAMillion = "Books-A-Million"
    case bookshop = "Bookshop"
    case indieBound = "IndieBound"
}

class RealmBookMainModel: Object {
    @Persisted var results: RealmBooksList?

    init(results: BookMainModel) {
        self.results = RealmBooksList(model: results.results)
    }

    override init() {
        super.init()
    }
}

class RealmBooksList: Object {
    @Persisted var listName: String = ""
    @Persisted var listNameEncoded: String = ""
    @Persisted var bestsellersDate: String = ""
    @Persisted var publishedDate: String = ""
    @Persisted var publishedDateDescription: String = ""
    @Persisted var nextPublishedDate: String = ""
    @Persisted var previousPublishedDate: String = ""
    @Persisted var displayName: String = ""
    @Persisted var books = List<RealmBook>()
    
    override init() {
        super.init()
    }
    
    init(model: BooksList) {
        super.init()
        self.listName = model.listName
        self.listNameEncoded = model.listNameEncoded
        self.bestsellersDate = model.bestsellersDate
        self.publishedDate = model.publishedDate
        self.publishedDateDescription = model.publishedDateDescription
        self.nextPublishedDate = model.nextPublishedDate
        self.previousPublishedDate = model.previousPublishedDate
        self.displayName = model.displayName
        var booksArray = List<RealmBook>()
        model.books.forEach( { booksArray.append(RealmBook(model: $0)) } )
        self.books = booksArray
    }
}

class RealmBook: Object {
    @Persisted var image: Data = Data()
    @Persisted var rank: Int = 0
    @Persisted var publisher: String = ""
    @Persisted var bookDescription: String = ""
    @Persisted var title: String = ""
    @Persisted var author: String = ""
    @Persisted var contributorNote: String = ""
    @Persisted var buyLinks = List<RealmBuyLink>()
    
    override init() {
        super.init()
    }
    
    init(model: Book) {
        super.init()
        self.image = model.image?.jpegData(compressionQuality: 1.0) ?? Data()
        self.rank = model.rank
        self.publisher = model.publisher
        self.bookDescription = model.description
        self.title = model.title
        self.author = model.author
        self.contributorNote = model.contributorNote
        var links = List<RealmBuyLink>()
        model.buyLinks.forEach( { links.append(RealmBuyLink(model: $0)) } )
        self.buyLinks = links
    }
}

class RealmBuyLink: Object {
    @Persisted var name: String = ""
    @Persisted var url: String = ""
    
    override init() {
        super.init()
    }
    
    init(model: BuyLink) {
        super.init()
        self.name = model.name.rawValue
        self.url = model.url
    }
}

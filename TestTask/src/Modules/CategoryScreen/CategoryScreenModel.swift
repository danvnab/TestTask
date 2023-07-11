//
//  CategoryScreenModel.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import Foundation
import RealmSwift

// MARK: - Welcome
struct CategoryMainModel: Codable {
    let results: [CategoryList]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct CategoryList: Codable {
    let listName, displayName, listNameEncoded, oldestPublishedDate, newestPublishedDate: String

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
    }
    
    init(from realmModel: RealmCategoryList) {
        self.listName = realmModel.listName
        self.displayName = realmModel.displayName
        self.listNameEncoded = realmModel.listNameEncoded
        self.oldestPublishedDate = realmModel.oldestPublishedDate
        self.newestPublishedDate = realmModel.newestPublishedDate
    }
}

class RealmCategoryMain: Object {
    @Persisted var results: List<RealmCategoryList> = List<RealmCategoryList>()
    
    init(model: CategoryMainModel) {
        super.init()
        let resultArray = List<RealmCategoryList>()
        model.results.forEach( { resultArray.append(RealmCategoryList(model: $0)) } )
        self.results = resultArray
    }
    
    override init() {
        super.init()
    }
}

class RealmCategoryList: Object {
    @Persisted var listName: String = ""
    @Persisted var displayName: String = ""
    @Persisted var listNameEncoded: String = ""
    @Persisted var oldestPublishedDate: String = ""
    @Persisted var newestPublishedDate: String = ""
    
    override init() {
        super.init()
    }
    
    init(model: CategoryList) {
        super.init()
        self.listName = model.listName
        self.displayName = model.displayName
        self.listNameEncoded = model.listNameEncoded
        self.oldestPublishedDate = model.oldestPublishedDate
        self.newestPublishedDate = model.newestPublishedDate
    }
}

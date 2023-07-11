//
//  BooksScreenViewModel.swift
//  TestTask
//
//  Created by Danil Velanskiy on 09.07.2023.
//

import Foundation
import UIKit

final class BooksScreenViewModel {
    
    let networkManager: NetworkManager = .shared
    let realmManager: RealmManager = .shared
    var model: [Book] = []
    
    func fetchData(listName: String, _ completion: @escaping ((String?) -> Void)) {
        if ConnectionObserver.instance.isConnectedToInternet {
            async {
                do {
                    let data: BookMainModel = try await networkManager.fetchData(from: "https://api.nytimes.com/svc/books/v3/lists/current/\(listName).json?")
                    self.model = data.results.books
                    let group = DispatchGroup()
                    
                    self.model.forEach { _ in
                        group.enter()
                    }
                    
                    self.downloadImages(group: group)
                    
                    group.notify(queue: .main) {
                        var itemToSave = data
                        itemToSave.results.books = self.model
                        try? self.realmManager.save(RealmBookMainModel(results: itemToSave))
                        completion(nil)
                    }
                    let objects = realmManager.getAllObjects(ofType: RealmBookMainModel.self)
                    let objectsToDelete = objects?.filter( { $0.results?.listNameEncoded == listName } )
                    
                    try objectsToDelete?.forEach( { try self.realmManager.delete($0) } )
                    
                } catch {
                    print(error.localizedDescription)
                    completion(error.localizedDescription)
                }
            }
        } else {
            let data = realmManager.getAllObjects(ofType: RealmBookMainModel.self)
            let model = data?.first(where: { $0.results?.listNameEncoded == listName } )
            model?.results?.books.forEach( { self.model.append(Book(from: $0)) } )
            if self.model.isEmpty {
                completion("No data available")
            } else {
                completion(nil)
            }
        }
    }
    
    func downloadImages(group: DispatchGroup) {
        for (index, m) in model.enumerated() {
            networkManager.downloadImage(for: NSURL(string: m.bookImage)) { [weak self] image in
                if let image = image {
                    self?.model[index].image = image
                } else {
                    self?.model[index].image = .checkmark
                }
                group.leave()
            }
        }
    }
}

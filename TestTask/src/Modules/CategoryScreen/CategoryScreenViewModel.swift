//
//  CategoryScreenViewModel.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import Foundation

final class CategoryScreenViewModel {
    
    var model: [CategoryList] = []
    
    func featchModel(_ complition: @escaping (() -> Void)) {
        if ConnectionObserver.instance.isConnectedToInternet {
            async {
                do {
                    let data: CategoryMainModel = try await NetworkManager.shared.fetchData(from: "https://api.nytimes.com/svc/books/v3/lists/names.json")
                    self.model = data.results
                    complition()
                    try RealmManager.shared.save(RealmCategoryMain(model: data))
                    RealmManager.shared.deleteAllObjects(ofType: RealmCategoryMain.self)
                } catch {
                    print("An error occurred: \(error)")
                }
            }
        } else {
            let data = RealmManager.shared.getAllObjects(ofType: RealmCategoryList.self)
            data?.forEach( { model.append(CategoryList(from: $0)) } )
            complition()
        }
    }
}

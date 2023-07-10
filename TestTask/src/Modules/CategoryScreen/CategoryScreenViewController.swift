//
//  CategoryScreenViewController.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import Foundation
import UIKit

protocol CategoryScreenViewControllerDelegate: AnyObject {
    func showBooksList(name: String, title: String)
}
 
final class CategoryScreenViewController: UIViewController {
    
    lazy var mainView: CategoryScreenView = {
       var view = CategoryScreenView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.tableView.register(CategoryScreenViewCell.self, forCellReuseIdentifier: "CategoryCell")
        return view
    }()
    
    lazy var viewModel: CategoryScreenViewModel = {
        var model = CategoryScreenViewModel()
        return model
    }()
    
    weak var delegate: CategoryScreenViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Book categories"
        viewModel.featchModel { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(messege: error)
                } else {
                    self.mainView.tableView.reloadData()
                }
            }
        }
    }
}

extension CategoryScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryScreenViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureCell(model: viewModel.model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showBooksList(name: viewModel.model[indexPath.row].listNameEncoded, title: viewModel.model[indexPath.row].displayName)
    }
}

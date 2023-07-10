//
//  BooksScreenViewController.swift
//  TestTask
//
//  Created by Danil Velanskiy on 09.07.2023.
//

import Foundation
import UIKit

protocol BooksScreenViewControllerDelegate: AnyObject {
    func openBuyView(links: [BuyLink])
}

final class BooksScreenViewController: UIViewController {
    
    lazy var mainView: BooksScreenView = {
        var view = BooksScreenView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.tableView.register(BooksScreenViewCell.self, forCellReuseIdentifier: "BooksCell")
        return view
    }()
    
    lazy var viewModel: BooksScreenViewModel = {
        var model = BooksScreenViewModel()
        return model
    }()
    
    weak var booksDelegate: BooksScreenViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func featchData(listName: String, title: String) {
        navigationItem.title = title
        viewModel.fetchData(listName: listName) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(messege: error)
                } else {
                    self.mainView.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func backButton() {
        dismiss(animated: true)
    }
}

extension BooksScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksCell", for: indexPath) as? BooksScreenViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(model: viewModel.model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        booksDelegate?.openBuyView(links: viewModel.model[indexPath.row].buyLinks)
    }
}

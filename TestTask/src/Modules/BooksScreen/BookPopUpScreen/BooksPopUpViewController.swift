//
//  BooksPopUpViewController.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import UIKit

protocol BooksPopUpViewControllerDelegate: AnyObject {
    func showShop(url: String)
}

class BooksPopUpViewController: UIViewController {
    
    lazy var mainView: BooksPopUpView = {
       var view = BooksPopUpView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.tableView.register(BooksPopUpViewCell.self, forCellReuseIdentifier: "BooksPopUpCell")
        view.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var viewModel: BooksPopUpViewModel = {
        var model = BooksPopUpViewModel()
        return model
    }()
    
    weak var delegate: BooksPopUpViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchData(model: [BuyLink]) {
        viewModel.model = model
        mainView.tableView.reloadData()
    }
    
    func showConectionAlert() {
        let alert = UIAlertController(title: "Connectivity Issue", message: "Internet connection appears to be offline ☹️", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
}

extension BooksPopUpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksPopUpCell", for: indexPath) as? BooksPopUpViewCell else { return UITableViewCell() }
        cell.configureCell(cellType: viewModel.model[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard ConnectionObserver.instance.isConnectedToInternet else {
            showConectionAlert()
            return
        }
        dismiss(animated: true)
        delegate?.showShop(url: viewModel.model[indexPath.row].url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

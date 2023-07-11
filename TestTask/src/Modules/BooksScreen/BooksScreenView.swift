//
//  BooksScreenView.swift
//  TestTask
//
//  Created by Danil Velanskiy on 09.07.2023.
//

import Foundation
import SnapKit
import UIKit

final class BooksScreenView: BaseView {
    
    lazy var tableView: UITableView = {
       var tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func configureView() {
        backgroundColor = .white
        addSubview(tableView)
    }
    
    override func makeConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}

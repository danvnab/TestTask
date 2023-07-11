//
//  CategoryScreen.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class CategoryScreenView: BaseView {

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
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
}


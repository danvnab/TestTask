//
//  BooksPopUp.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import SnapKit
import UIKit

class BooksPopUpView: BaseView {
    
    lazy var titleLabel: UILabel = {
       var label = UILabel()
        return label
    }()
    
    lazy var tableView: UITableView = {
       var tableView = UITableView()
        tableView.layer.cornerRadius = 20
        return tableView
    }()
    
    lazy var closeButton: UIButton = {
       var button = UIButton()
        button.setTitle("X", for: .normal)
        return button
    }()
    
    override func configureView() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        addSubview(tableView)
        addSubview(closeButton)
        addSubview(titleLabel)
    }
    
    override func makeConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        closeButton.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-10)
        }
        tableView.snp.remakeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.center.equalToSuperview()
        }
    }
}

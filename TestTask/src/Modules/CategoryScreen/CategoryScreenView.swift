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
    
//    lazy var titleLabel: UILabel = {
//       var label = UILabel()
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 32)
//        label.text = NSLocalizedString("categoryTitle")
//        return label
//    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func configureView() {
        backgroundColor = .white
//        addSubview(titleLabel)
        addSubview(tableView)
    }
    
    override func makeConstraints() {
//        titleLabel.snp.remakeConstraints { make in
//            make.top.equalToSuperview().offset(60)
//            make.trailing.equalToSuperview().offset(-20)
//            make.leading.equalToSuperview().offset(20)
//        }
        tableView.snp.remakeConstraints { make in
//            make.top.equalTo(titleLabel.snp_bottomMargin).offset(20)
            make.top.equalToSuperview()
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
}


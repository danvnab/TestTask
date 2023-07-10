//
//  CategoryScreenViewCell.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class CategoryScreenViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
       var label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var newestDateLabel: UILabel = {
       var label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var oldestDateLabel: UILabel = {
       var label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        configureView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func configureCell(model: CategoryList) {
        titleLabel.text = model.displayName
        newestDateLabel.text = NSLocalizedString("newest") + ": " + model.newestPublishedDate
        oldestDateLabel.text = NSLocalizedString("oldest") + ": " + model.oldestPublishedDate
    }
    
    private func configureView() {
        addSubview(titleLabel)
        addSubview(newestDateLabel)
        addSubview(oldestDateLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        newestDateLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(15)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        oldestDateLabel.snp.remakeConstraints { make in
            make.top.equalTo(newestDateLabel.snp_bottomMargin).offset(5)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

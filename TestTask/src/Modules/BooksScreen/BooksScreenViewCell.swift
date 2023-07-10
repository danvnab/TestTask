//
//  BooksScreenViewCell.swift
//  TestTask
//
//  Created by Danil Velanskiy on 09.07.2023.
//

import Foundation
import UIKit
import SnapKit

class BooksScreenViewCell: UITableViewCell {
    
    lazy var bookImage: UIImageView = {
       var image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
       var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
       var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
         return label
    }()
    
    lazy var publisherLabel: UILabel = {
       var label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var rankLabel: UILabel = {
       var label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var buyButton: UIButton = {
       var button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func configure(model: Book) {
        if let image = model.image {
            bookImage.image = image
        } else {
            bookImage.image = .checkmark
        }
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        authorLabel.text = NSLocalizedString("author") + ": " + model.author
        publisherLabel.text = NSLocalizedString("publisher") + ": " +  model.publisher
        rankLabel.text = NSLocalizedString("rank") + ": " + String(model.rank)
    }
    
    func configureView() {
        addSubview(bookImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(authorLabel)
        addSubview(publisherLabel)
        addSubview(rankLabel)
        addSubview(buyButton)
    }
    
    func makeConstraints() {
        bookImage.snp.remakeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(bookImage.snp_bottomMargin).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        authorLabel.snp.remakeConstraints { make in
            make.top.equalTo(descriptionLabel.snp_bottomMargin).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        publisherLabel.snp.remakeConstraints { make in
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        rankLabel.snp.remakeConstraints { make in
            make.top.equalTo(publisherLabel.snp_bottomMargin).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        buyButton.snp.remakeConstraints { make in
            make.top.equalTo(rankLabel.snp_bottomMargin).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

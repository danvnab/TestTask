//
//  BooksScreenViewCell.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import SnapKit
import UIKit

class BooksPopUpViewCell: UITableViewCell {
    
    lazy var shopImage: UIImageView = {
       var image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
       var label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func configureCell(cellType: shopsName) {
        titleLabel.text = cellType.rawValue
        shopImage.image = UIImage(named: cellType.rawValue)
    }
    
    func configureView() {
        addSubview(titleLabel)
        addSubview(shopImage)
    }
    
    func makeConstraints() {
        shopImage.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(15)
//            make.height.width.equalTo(100)
            make.width.equalTo(shopImage.snp.height)
            make.bottom.equalToSuperview().offset(-15)
        }
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(shopImage.snp_trailingMargin).offset(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

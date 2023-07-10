//
//  BaseView.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import UIKit

class BaseView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        makeConstraints()
    }
    
    func configureView() {
        
    }
    
    func makeConstraints() {

    }
}

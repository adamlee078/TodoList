//
//  CustomToolBar.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/4.
//

import UIKit

class CustomToolBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .gray
    }
}

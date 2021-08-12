//
//  TaskTableViewCell.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/6.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    let titleLabel: UILabel = UILabel()
    let deadlineLabel: UILabel = UILabel()
    let importanceView: ImportanceView = ImportanceView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(deadlineLabel)
        self.contentView.addSubview(importanceView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: textFont_2, size: fontSize_4)
        titleLabel.textAlignment = .left
        titleLabel.snp.makeConstraints{ (makes) in
            makes.top.equalToSuperview().offset(marginSpace_1)
            makes.left.equalToSuperview().offset(marginSpace_1)
        }
        
        importanceView.snp.makeConstraints{ (makes) in
            makes.left.equalToSuperview().offset(marginSpace_1)
            makes.right.equalToSuperview().offset(-marginSpace_1)
            makes.top.equalTo(titleLabel.snp.bottom).offset(marginSpace_1)
        }
        
        deadlineLabel.backgroundColor = .clear
        deadlineLabel.textColor = lightGrayColor
        deadlineLabel.font = UIFont(name: textFont_2, size: fontSize_3)
        deadlineLabel.textAlignment = .right
        deadlineLabel.lineBreakMode = .byWordWrapping
        deadlineLabel.numberOfLines = 3
        deadlineLabel.snp.makeConstraints{ (makes) in
            makes.right.equalToSuperview().offset(-marginSpace_1)
            makes.centerY.equalToSuperview()
        }
    }
}

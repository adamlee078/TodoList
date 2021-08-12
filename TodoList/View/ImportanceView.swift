//
//  ImportanceView.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/7.
//

import UIKit

class ImportanceView: UIView {
    let level1Btn = UIButton()
    let level2Btn = UIButton()
    let level3Btn = UIButton()
    let level4Btn = UIButton()
    let level5Btn = UIButton()
    
    let imgFilledStar = UIImage(named: "star-filled-icon")?.withRenderingMode(.alwaysTemplate)
    let imgEmptyStar = UIImage(named: "star-empty-icon")?.withRenderingMode(.alwaysTemplate)
    
    var iLevel: Int = 1
    var bCanEdit: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
        
        self.addSubview(level1Btn)
        self.addSubview(level2Btn)
        self.addSubview(level3Btn)
        self.addSubview(level4Btn)
        self.addSubview(level5Btn)
        
        level1Btn.tintColor = UIColor(named: "OrangeColor")
        level2Btn.tintColor = UIColor(named: "OrangeColor")
        level3Btn.tintColor = UIColor(named: "OrangeColor")
        level4Btn.tintColor = UIColor(named: "OrangeColor")
        level5Btn.tintColor = UIColor(named: "OrangeColor")
        
        level1Btn.addTarget(self, action: #selector(level1BtnTapped), for: .touchUpInside)
        level2Btn.addTarget(self, action: #selector(level2BtnTapped), for: .touchUpInside)
        level3Btn.addTarget(self, action: #selector(level3BtnTapped), for: .touchUpInside)
        level4Btn.addTarget(self, action: #selector(level4BtnTapped), for: .touchUpInside)
        level5Btn.addTarget(self, action: #selector(level5BtnTapped), for: .touchUpInside)
        
        level1Btn.snp.makeConstraints { (makes) in
            makes.top.bottom.left.equalToSuperview()
            makes.width.height.equalTo(buttonIconWidth)
        }
        level2Btn.snp.makeConstraints { (makes) in
            makes.top.bottom.equalToSuperview()
            makes.left.equalTo(level1Btn.snp.right).offset(5)
            makes.width.height.equalTo(buttonIconWidth)
        }
        level3Btn.snp.makeConstraints { (makes) in
            makes.top.bottom.equalToSuperview()
            makes.left.equalTo(level2Btn.snp.right).offset(5)
            makes.width.height.equalTo(buttonIconWidth)
        }
        level4Btn.snp.makeConstraints { (makes) in
            makes.top.bottom.equalToSuperview()
            makes.left.equalTo(level3Btn.snp.right).offset(5)
            makes.width.height.equalTo(buttonIconWidth)
        }
        level5Btn.snp.makeConstraints { (makes) in
            makes.top.bottom.equalToSuperview()
            makes.left.equalTo(level4Btn.snp.right).offset(5)
            makes.width.height.equalTo(buttonIconWidth)
        }
    }
    
    func setLevelBtnImage(level: Int) {
        iLevel = level
        switch iLevel {
        case 1:
            self.level1Btn.setImage(imgFilledStar, for: .normal)
            self.level2Btn.setImage(imgEmptyStar, for: .normal)
            self.level3Btn.setImage(imgEmptyStar, for: .normal)
            self.level4Btn.setImage(imgEmptyStar, for: .normal)
            self.level5Btn.setImage(imgEmptyStar, for: .normal)
        case 2:
            self.level1Btn.setImage(imgFilledStar, for: .normal)
            self.level2Btn.setImage(imgFilledStar, for: .normal)
            self.level3Btn.setImage(imgEmptyStar, for: .normal)
            self.level4Btn.setImage(imgEmptyStar, for: .normal)
            self.level5Btn.setImage(imgEmptyStar, for: .normal)
        case 3:
            self.level1Btn.setImage(imgFilledStar, for: .normal)
            self.level2Btn.setImage(imgFilledStar, for: .normal)
            self.level3Btn.setImage(imgFilledStar, for: .normal)
            self.level4Btn.setImage(imgEmptyStar, for: .normal)
            self.level5Btn.setImage(imgEmptyStar, for: .normal)
        case 4:
            self.level1Btn.setImage(imgFilledStar, for: .normal)
            self.level2Btn.setImage(imgFilledStar, for: .normal)
            self.level3Btn.setImage(imgFilledStar, for: .normal)
            self.level4Btn.setImage(imgFilledStar, for: .normal)
            self.level5Btn.setImage(imgEmptyStar, for: .normal)
        case 5:
            self.level1Btn.setImage(imgFilledStar, for: .normal)
            self.level2Btn.setImage(imgFilledStar, for: .normal)
            self.level3Btn.setImage(imgFilledStar, for: .normal)
            self.level4Btn.setImage(imgFilledStar, for: .normal)
            self.level5Btn.setImage(imgFilledStar, for: .normal)
        default:
            self.level1Btn.setImage(imgEmptyStar, for: .normal)
            self.level2Btn.setImage(imgEmptyStar, for: .normal)
            self.level3Btn.setImage(imgEmptyStar, for: .normal)
            self.level4Btn.setImage(imgEmptyStar, for: .normal)
            self.level5Btn.setImage(imgEmptyStar, for: .normal)
        }
    }
    
    @objc func level1BtnTapped() {
        if bCanEdit {
            setLevelBtnImage(level: 1)
        }
    }
    
    @objc func level2BtnTapped() {
        if bCanEdit {
            setLevelBtnImage(level: 2)
        }
    }
    
    @objc func level3BtnTapped() {
        if bCanEdit {
            setLevelBtnImage(level: 3)
        }
    }
    
    @objc func level4BtnTapped() {
        if bCanEdit {
            setLevelBtnImage(level: 4)
        }
    }
    
    @objc func level5BtnTapped() {
        if bCanEdit {
            setLevelBtnImage(level: 5)
        }
    }
}

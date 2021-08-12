//
//  EditTaskViewController.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/8.
//

import UIKit

protocol EditTaskDelegate {
    func addTask(taskData: Task)
    func editTask(taskData: Task, index: Int)
}

class EditTaskViewController: UIViewController {
    let toolBar = UIToolbar()
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let deadlineLabel = UILabel()
    let deadlineSwitch = UISwitch()
    let deadlineDatePicker = UIDatePicker()
    let importanceLabel = UILabel()
    let importanceSelectView = ImportanceView()
    
    var sDeadline = ""
    var iIndexOfTasks = -1 // -1 is New
    
    var delegate: EditTaskDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("enter")
        initLayout()
        self.view.backgroundColor = UIColor(named: "DarkGrayColor")
    }
    
    func setData(title: String, deadline: String, importance: Int, index: Int) {
        print("title=\(title)")
        print("deadline=\(deadline)")
        print("importance=\(importance)")
        print("index=\(index)")
        titleTextField.text = title
        importanceSelectView.setLevelBtnImage(level: importance)
        let formatterTemp = DateFormatter()
        formatterTemp.dateFormat = "yyyy/MM/dd\nHH:mm"
        sDeadline = deadline
        if deadline != "" {
            deadlineDatePicker.date = formatterTemp.date(from: deadline) ?? Date()
            deadlineDatePicker.minimumDate = formatterTemp.date(from: deadline)
        }
        else {
            deadlineDatePicker.date = Date()
            let sNow = formatterTemp.string(from: Date())
            deadlineDatePicker.minimumDate = formatterTemp.date(from: sNow)
        }
        
        iIndexOfTasks = index
    }
    
    func initLayout() {
        initToolBar()
        
        titleLabel.text = "Title"
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = lightOrangeColor
        titleLabel.font = UIFont(name: textFont_2, size: fontSize_4)
        titleLabel.textAlignment = .left
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (makes) in
            makes.top.equalTo(toolBar.snp.bottom).offset(marginSpace_2)
            makes.left.equalToSuperview().offset(marginSpace_1)
            makes.height.equalTo(44)
        }
        
        titleTextField.font = UIFont(name: textFont_1, size: fontSize_3)
        titleTextField.textAlignment = .left
        titleTextField.clearButtonMode = .whileEditing
        titleTextField.returnKeyType = .next
        titleTextField.textColor = .white
        titleTextField.backgroundColor = grayColor
        titleTextField.borderStyle = .roundedRect
        titleTextField.keyboardType = .default
        titleTextField.isEnabled = true
        titleTextField.delegate = self
        self.view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints{ (makes) in
            makes.top.equalTo(titleLabel.snp.bottom).offset(marginSpace_1)
            makes.left.equalToSuperview().offset(marginSpace_1)
            makes.right.equalToSuperview().offset(-marginSpace_1)
            makes.height.equalTo(textFieldHeight)
        }
        
        importanceLabel.text = "Importance"
        importanceLabel.backgroundColor = .clear
        importanceLabel.textColor = lightOrangeColor
        importanceLabel.font = UIFont(name: textFont_2, size: fontSize_4)
        importanceLabel.textAlignment = .left
        self.view.addSubview(importanceLabel)
        importanceLabel.snp.makeConstraints{ (makes) in
            makes.top.equalTo(titleTextField.snp.bottom).offset(marginSpace_2)
            makes.left.equalToSuperview().offset(marginSpace_1)
            makes.height.equalTo(labelHeight)
        }
        
        importanceSelectView.bCanEdit = true
        self.view.addSubview(importanceSelectView)
        importanceSelectView.snp.makeConstraints{ (makes) in
            makes.top.equalTo(importanceLabel.snp.bottom).offset(marginSpace_1)
            makes.left.equalToSuperview().offset(marginSpace_1)
            makes.right.equalToSuperview().offset(-marginSpace_1)
        }
        
        deadlineLabel.text = "Deadline"
        deadlineLabel.backgroundColor = .clear
        deadlineLabel.textColor = lightOrangeColor
        deadlineLabel.font = UIFont(name: textFont_2, size: fontSize_4)
        deadlineLabel.textAlignment = .left
        self.view.addSubview(deadlineLabel)
        deadlineLabel.snp.makeConstraints{ (makes) in
            makes.top.equalTo(importanceSelectView.snp.bottom).offset(marginSpace_2)
            makes.left.equalToSuperview().offset(marginSpace_1)
            makes.height.equalTo(labelHeight)
        }
        
        deadlineSwitch.isOn = (sDeadline == "") ? false : true
        deadlineSwitch.thumbTintColor = orangeColor
        deadlineSwitch.onTintColor = grayColor
        deadlineSwitch.addTarget(self, action: #selector(deadlineSwitchChanged), for: .valueChanged)
        self.view.addSubview(deadlineSwitch)
        deadlineSwitch.snp.makeConstraints{ (makes) in
            makes.right.equalToSuperview()
                .offset(-marginSpace_1)
            makes.centerY.equalTo(deadlineLabel)
        }
        
        deadlineDatePicker.isHidden = (sDeadline == "") ? true : false
        deadlineDatePicker.tintColor = orangeColor
        deadlineDatePicker.datePickerMode = .dateAndTime
        deadlineDatePicker.addTarget(self, action: #selector(deadlineDatePickerChangeed), for: .valueChanged)
        self.view.addSubview(deadlineDatePicker)
        deadlineDatePicker.snp.makeConstraints{ (makes) in
            makes.top.equalTo(deadlineLabel.snp.bottom).offset(marginSpace_1)
            makes.left.equalToSuperview().offset(marginSpace_1)
            makes.right.equalToSuperview().offset(-marginSpace_1)
            makes.height.equalTo(labelHeight)
        }
    }
    
    func initToolBar() {
        self.view.addSubview(toolBar)
        toolBar.snp.makeConstraints{ (makes) in
            makes.top.left.right.equalToSuperview()
            makes.height.equalTo(toolBarHeight)
        }
        
        toolBar.isTranslucent = false
        toolBar.barTintColor = darkGrayColor
        toolBar.tintColor = orangeColor
        
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let middleGapBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelBtn, middleGapBtn, saveBtn], animated: false)
    }
    
    @objc func saveTapped() {
        if iIndexOfTasks == -1 {
            delegate?.addTask(taskData: Task(title: titleTextField.text!, deadline: sDeadline, importance: importanceSelectView.iLevel))
        }
        else {
            delegate?.editTask(taskData: Task(title: titleTextField.text!, deadline: sDeadline, importance: importanceSelectView.iLevel), index: iIndexOfTasks)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deadlineSwitchChanged() {
        if deadlineSwitch.isOn {
            deadlineDatePicker.isHidden = false
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd\nHH:mm"
            sDeadline = formatter.string(from: Date())
            print(sDeadline)
        }
        else {
            deadlineDatePicker.isHidden = true
            sDeadline = ""
            print(sDeadline)
        }
    }
    
    @objc func deadlineDatePickerChangeed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd\nHH:mm"
        sDeadline = formatter.string(from: deadlineDatePicker.date)
        print(sDeadline)
    }
}

extension EditTaskViewController: UITextFieldDelegate{
    
}

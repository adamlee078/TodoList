//
//  MainViewController.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/4.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let taskListTableView = UITableView()
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = getTasksRecoverData()
        initLayout()
    }
    
    func initLayout() {
        initNavigationBar()
        
        taskListTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        taskListTableView.bounces = true
        taskListTableView.showsVerticalScrollIndicator = true
        taskListTableView.allowsSelection = false
        taskListTableView.backgroundColor = UIColor(named: "DarkGrayColor")
        taskListTableView.rowHeight = cellHeight
        self.view.addSubview(taskListTableView)
        taskListTableView.snp.makeConstraints{ (makes) in
            makes.centerX.equalToSuperview()
            makes.top.equalToSuperview()
            makes.left.right.bottom.equalToSuperview()
        }
    }
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "DarkGrayColor")
        self.navigationController?.navigationBar.isTranslucent = false
        
        if let image = UIImage(named: "plus-icon") {
            let addTaskIcon = resizeImage(image: image, width: buttonIconWidth)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: addTaskIcon, style: .plain, target: self, action: #selector(addTaskTapped))
            self.navigationItem.rightBarButtonItem?.tintColor = .orange
        }
        
        if let image = UIImage(named: "settings-icon") {
            let settingsIcon = resizeImage(image: image, width: buttonIconWidth)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: settingsIcon, style: .plain, target: self, action: #selector(settingsTapped))
            self.navigationItem.leftBarButtonItem?.tintColor = .orange
        }
    }
    
    @objc func addTaskTapped() {
        print("addTaskTapped")
        let vc = EditTaskViewController()
        vc.delegate = self
        vc.setData(title: "", deadline: "", importance: 3, index: -1)
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func settingsTapped() {
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.titleLabel.text = tasks[indexPath.row].sTitle
        cell.importanceView.setLevelBtnImage(level: tasks[indexPath.row].iImortance)
        if tasks[indexPath.row].deadline != "" {
            cell.deadlineLabel.text = "Before\n" + tasks[indexPath.row].deadline
        }
        else {
            cell.deadlineLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: {_,_,_ in
            self.tasks.remove(at: indexPath.row)
            setTasksRecoverData(self.tasks)
            tableView.reloadData()
        })
        deleteAction.backgroundColor = redColor
        
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {_,_,_ in
            let vc = EditTaskViewController()
            vc.delegate = self
            vc.setData(title: self.tasks[indexPath.row].sTitle, deadline: self.tasks[indexPath.row].deadline, importance: self.tasks[indexPath.row].iImortance, index: indexPath.row)
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true, completion: nil)
        })
        editAction.backgroundColor = lightGrayColor
        
        let actionsConfig = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        actionsConfig.performsFirstActionWithFullSwipe = false
        return actionsConfig
    }
}

extension MainViewController: EditTaskDelegate {
    func addTask(taskData: Task) {
        print(taskData)
        tasks.append(taskData)
        setTasksRecoverData(tasks)
        taskListTableView.reloadData()
    }
    
    func editTask(taskData: Task, index: Int) {
        print(taskData)
        tasks[index].setTaskData(title: taskData.sTitle, deadline: taskData.deadline, importance: taskData.iImortance)
//        tasks[index] = taskData
        setTasksRecoverData(tasks)
        taskListTableView.reloadData()
//        taskListTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

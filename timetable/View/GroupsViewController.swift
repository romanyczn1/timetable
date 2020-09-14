//
//  GroupsViewController.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class GroupsViewController: UIViewController {
    
    var viewModel: GroupsViewControllerViewModelType?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpViewModel()
    }
    
    private func setUpViewModel() {
        let tabBar = tabBarController as? TabBarController
        viewModel = tabBar?.viewModel?.groupsViewControllerViewModel()
        viewModel?.fetchedResultsController.delegate = self
    }
    
    private func setUpTableView() {
        tableView.register(GroupsViewControllerCell.self, forCellReuseIdentifier: GroupsViewControllerCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deleteObject(atIndexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsViewControllerCell.reuseId, for: indexPath) as! GroupsViewControllerCell
        cell.viewModel = viewModel?.groupsViewControllerCellViewModel(forIndexPath: indexPath)
        return cell
    }
    
}

extension GroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.cellSelected(atIndexPath: indexPath, tabBarController: tabBarController!)
    }
}

extension GroupsViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

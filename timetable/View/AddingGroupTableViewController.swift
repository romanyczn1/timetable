//
//  AddingGroupTableViewController.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class AddingGroupTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel: AddingGroupTableViewControllerViewModelType?
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AddingGroupTableViewControllerViewModel()
        viewModel?.getGroupsData {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                let text = self.searchBar.text
                if text == "" {
                    self.tableView.reloadData()
                } else {
                    self.viewModel?.synchWithSearch(serachText: text!)
                    self.tableView.reloadData()
                }
            }
        }
        setUpTableView()
        setUpSearchBar()
        setUpActivityIndicator()
    }
    
    private func setUpActivityIndicator(){
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator = activityIndicator
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.keyboardType = .asciiCapableNumberPad
    }
    
    private func setUpTableView() {
        self.tableView.dataSource = self
        tableView.register(AddingGroupTableViewControllerCell.self, forCellReuseIdentifier: AddingGroupTableViewControllerCell.reuseId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.numberOfRows())!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddingGroupTableViewControllerCell.reuseId, for: indexPath) as! AddingGroupTableViewControllerCell
        cell.viewModel = viewModel?.addGroupCellViewModel(forIndexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AddingGroupTableViewControllerCell
//        if let groupsVC = self.navigationController?.viewControllers[0] as? GroupsViewController {
//            groupsVC.viewModel?.cellTapped(withGroupName: cell.viewModel!.groupName)
//        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddingGroupTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.textDidChanged(withText: searchText)
        self.tableView.reloadData()
    }
}

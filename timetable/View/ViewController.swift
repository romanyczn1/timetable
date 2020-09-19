//
//  ViewController.swift
//  timetable
//
//  Created by Roman Bukh on 8/29/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.

import UIKit
import CoreData

class ViewController: UIViewController {

    var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var headerView: HeaderView!
    lazy var headerViewWrapper: HeaderViewWrapper = {
        let headerViewWrapper = HeaderViewWrapper()
        headerViewWrapper.translatesAutoresizingMaskIntoConstraints = false
        return headerViewWrapper
    }()
    
    var viewModel: ViewControllerViewModelType?
    var selectedGroup: String = "" {
        didSet{
            viewModel?.getTimetableData(forGroup: selectedGroup, completion: { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.collectionView.reloadData()
                    self?.headerView.viewModel = self?.viewModel!.headerViewViewModel()
                }
            })
        }
    }
    var selectedSubgroup: Int? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewModel()
        setUpHeaderView()
        setUpCollectionView()
        setUpTableView()
    }
    
    private func setUpViewModel() {
        let tabBar = tabBarController as? TabBarController
        viewModel = tabBar?.viewModel?.viewControllerViewModel()
        viewModel?.tryGetSelectedGroup(complition: { (groupName, subgroupNumb)  in
            self.selectedGroup = groupName!
            self.selectedSubgroup = subgroupNumb
        })
    }
    
    private func setUpHeaderView(){
        let view = HeaderView()
        view.viewModel = viewModel!.headerViewViewModel()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        view.heightAnchor.constraint(equalToConstant: 55 + statusBarHeight).isActive = true
        self.headerView = view
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .secondarySystemBackground
        } else {
            // Fallback on earlier versions
        }
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setUpTableView() {
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeHandler))
        leftSwipeGestureRecognizer.direction = .left
        tableView.addGestureRecognizer(leftSwipeGestureRecognizer)
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeHandler))
        rightSwipeGestureRecognizer.direction = .right
        tableView.addGestureRecognizer(rightSwipeGestureRecognizer)
        self.tableView = tableView
    }

    @objc func leftSwipeHandler(){
        viewModel?.leftSwipeOccured()
        self.headerView.viewModel = viewModel!.headerViewViewModel()
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .left)
        collectionView.reloadData()
    }
    
    @objc func rightSwipeHandler(){
        viewModel?.rightSwipeOccured()
        self.headerView.viewModel = viewModel!.headerViewViewModel()
        tableView.reloadSections(IndexSet(integer: 0), with: .right)
        collectionView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRowsInTableView(forSubgroup: selectedSubgroup ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseId, for: indexPath) as! LessonCell
        cell.viewModel = viewModel?.tableViewCellViewModel(forSubgroup: selectedSubgroup ?? 0, forIndexPath: indexPath, traitCollection: traitCollection)
        cell.backgroundColor = .clear
        cell.viewModel?.delegate = cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.numberOfRowsInCollectionView())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseId, for: indexPath) as? DateCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel?.collectionViewCellViewModel(forIndexPath: indexPath)
        return cell
    }
      
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        let date = cell.viewModel?.date
        viewModel?.setDate(date: date!, indexPath: indexPath)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 7), height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

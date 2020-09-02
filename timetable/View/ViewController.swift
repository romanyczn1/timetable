//
//  ViewController.swift
//  timetable
//
//  Created by Roman Bukh on 8/29/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewControllerViewModelType?
    var selectedWeekday: Int?
    var selectedGroup: String = "872303"
    var selectedSubgroup: Int? = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewControllerViewModel()
        selectedWeekday = viewModel?.getCurrentWeekday()
        viewModel?.getTimetableData(forGroup: selectedGroup, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        setUpTableView()
        collectionView.dataSource = self
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        tableView.separatorStyle = .none
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeHandler))
        leftSwipeGestureRecognizer.direction = .left
        tableView.addGestureRecognizer(leftSwipeGestureRecognizer)
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeHandler))
        rightSwipeGestureRecognizer.direction = .right
        tableView.addGestureRecognizer(rightSwipeGestureRecognizer)
    }

    @objc func leftSwipeHandler(){
        selectedWeekday! += 1
        viewModel?.setSelectedWeekday(selectedWeekday: selectedWeekday!, completion: { (realWeekday) in
            self.selectedWeekday = realWeekday
        })
        tableView.reloadData()
    }
    
    @objc func rightSwipeHandler(){
        selectedWeekday! -= 1
        viewModel?.setSelectedWeekday(selectedWeekday: selectedWeekday!, completion: { (realWeekday) in
            self.selectedWeekday = realWeekday
        })
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRowsInTableView(forWeekday: selectedWeekday ?? 0, forSubgroup: selectedSubgroup ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseId, for: indexPath) as! LessonCell
        cell.viewModel = viewModel?.tableViewCellViewModel(forWeekday: selectedWeekday ?? 0, forSubgroup: selectedSubgroup ?? 0, forIndexPath: indexPath)
        return cell
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.numberOfRowsInCollectionView())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseId, for: indexPath) as! DateCell
        return cell
    }
      
}


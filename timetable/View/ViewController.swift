//
//  ViewController.swift
//  timetable
//
//  Created by Roman Bukh on 8/29/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
// надо сделать чтобы при нажатии на день все было четко в частности чтобы менялся день и мес>ц
// во вью модели вьюконтроллера счас вообще все нахер к чертям забагано

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewControllerViewModelType?
    var selectedGroup: String = "872303"
    var selectedSubgroup: Int? = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewControllerViewModel()
        viewModel?.getTimetableData(forGroup: selectedGroup, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        setUpTableView()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeHandler))
        leftSwipeGestureRecognizer.direction = .left
        tableView.addGestureRecognizer(leftSwipeGestureRecognizer)
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeHandler))
        rightSwipeGestureRecognizer.direction = .right
        tableView.addGestureRecognizer(rightSwipeGestureRecognizer)
    }

    @objc func leftSwipeHandler(){
        viewModel?.leftSwipeOccured()
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    @objc func rightSwipeHandler(){
        viewModel?.rightSwipeOccured()
        tableView.reloadData()
        collectionView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRowsInTableView(forSubgroup: selectedSubgroup ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseId, for: indexPath) as! LessonCell
        cell.viewModel = viewModel?.tableViewCellViewModel(forSubgroup: selectedSubgroup ?? 0, forIndexPath: indexPath)
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
        return CGSize(width: (UIScreen.main.bounds.width / 7), height: 70)
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

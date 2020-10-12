//
//  ScheduleViewController.swift
//  timetable
//
//  Created by Roman Bukh on 8/29/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.

import UIKit
import CoreData

class ScheduleViewController: UIViewController {

    var tableView: UITableView!
    var collectionView: UICollectionView!
    var headerView: HeaderView!
    var selectedDayView: SelectedDayView!
    var refreshButton: NavigateButton!
    
    var viewModel: ScheduleViewControllerViewModelType?
    var selectedGroup: String? {
        didSet{
            if selectedGroup == nil {
                DispatchQueue.main.async {
                    self.deleteUnnecessarySubviews()
                    self.showImageView(withImageName: "books", andText: "Выберите группу для просмотра расписания")
                    self.viewModel?.clearTimetable()
                    self.tableView.reloadData()
                }
            } else {
                viewModel?.getTimetableData(forGroup: selectedGroup!, updateCacheOrNot: false, completion: { [weak self] in
                    DispatchQueue.main.async {
                        self?.deleteUnnecessarySubviews()
                        self?.tableView.reloadData()
                        self?.collectionView.reloadData()
                        self?.headerView.viewModel = self?.viewModel!.headerViewViewModel()
                        self?.selectedDayView.viewModel = self?.viewModel!.selectedDayViewViewModel()
                    }
                })
            }
        }
    }
    var selectedSubgroup: Int? {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.shared.isConnectedToNetwork() {
            self.viewModel?.getCurrentWeekNumber(updateCacheOrNot: true, completion: {
                self.setUpViewModel()
            })
        } else {
            self.viewModel?.getCurrentWeekNumber(updateCacheOrNot: false, completion: {
                self.showErrorView(withMessage: "No internet coonection. Week number may be wrong!")
                self.setUpViewModel()
            })
        }
        setUpHeaderView()
        setUpCollectionView()
        setUpSelectedDayView()
        setUpTableView()
        setUpNavigateButton()
    }
    
    private func setUpViewModel() {
        viewModel?.tryGetSelectedGroup(complition: { (groupName, subgroupNumb)  in
            if groupName == nil {
                self.selectedGroup = nil
            } else {
                self.selectedGroup = groupName!
                self.selectedSubgroup = subgroupNumb
            }
        })
    }
    
    private func setUpHeaderView(){
        let view = HeaderView()
        view.delegate = self
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .secondarySystemBackground
        } else {
            collectionView.backgroundColor = #colorLiteral(red: 0.9518182874, green: 0.951977551, blue: 0.9517973065, alpha: 1)
        }
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.collectionView = collectionView
    }
    
    private func setUpSelectedDayView(){
        let view = SelectedDayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = #colorLiteral(red: 0.9158286452, green: 0.9159821868, blue: 0.9158083797, alpha: 1)
        }
        view.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        view.heightAnchor.constraint(equalToConstant: 3).isActive = true
        self.selectedDayView = view
    }
    
    private func setUpTableView() {
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.selectedDayView.bottomAnchor).isActive = true
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
    
    private func setUpNavigateButton() {
        let button = NavigateButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "compass")
        button.setImage(image, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9503019452, green: 0.9504609704, blue: 0.9502809644, alpha: 1)
        button.alpha = 0.8
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(refreshButtonTapped(_ :)), for: .touchUpInside)
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -125).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36 ).isActive = true
        button.widthAnchor.constraint(equalToConstant: 36 ).isActive = true
        self.refreshButton = button
    }
    
    @objc func refreshButtonTapped(_ sender: UIButton){
        viewModel?.goToStartDate(completion: {
            DispatchQueue.main.async {
                self.deleteUnnecessarySubviews()
                self.headerView.viewModel = self.viewModel!.headerViewViewModel()
                self.selectedDayView.viewModel = self.viewModel!.selectedDayViewViewModel()
                self.collectionView.reloadData()
                self.tableView.reloadData()
            }
        })
        UIView.animate(withDuration: 0.5, animations: {
                sender.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        })
        UIView.animate(withDuration: 0.15, animations: {
                sender.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4.0)
        })
    }

    @objc func leftSwipeHandler(){
        if selectedGroup != nil {
            deleteUnnecessarySubviews()
        }
        refreshButton.tintColor = .black
        viewModel?.leftSwipeOccured()
        self.headerView.viewModel = viewModel!.headerViewViewModel()
        self.selectedDayView.viewModel = viewModel!.selectedDayViewViewModel()
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .left)
        collectionView.reloadData()
        UIView.animate(withDuration: 0.15, animations: {
            self.refreshButton.transform = CGAffineTransform(rotationAngle: 0)
        })
    }
    
    @objc func rightSwipeHandler(){
        if selectedGroup != nil {
            deleteUnnecessarySubviews()
        }
        refreshButton.tintColor = .black
        viewModel?.rightSwipeOccured()
        self.headerView.viewModel = viewModel!.headerViewViewModel()
        self.selectedDayView.viewModel = viewModel!.selectedDayViewViewModel()
        tableView.reloadSections(IndexSet(integer: 0), with: .right)
        collectionView.reloadData()
        UIView.animate(withDuration: 0.15, animations: {
            self.refreshButton.transform = CGAffineTransform(rotationAngle: 0)
        })
    }
    
    private func showErrorView(withMessage message: String) {
        let view = PopUpWindowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        view.popupTitle.text = message
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height * 0.165)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseIn ,animations: {
                view.alpha = 0
            }) { _ in
                view.removeFromSuperview()
            }
        })
    }
    
    private func showImageView(withImageName imageName: String, andText text: String) {
        let view = UIImageView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.4).isActive = true
        view.widthAnchor.constraint(equalTo: self.tableView.widthAnchor, multiplier: 0.5).isActive = true
        view.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: self.tableView.topAnchor, multiplier: 10).isActive = true
        view.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        view.image = UIImage(named: imageName)
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.alpha = 0
        self.view.addSubview(textView)
        textView.text = text
        textView.textAlignment = .center
        textView.numberOfLines = 0
        textView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor, multiplier: 0.6).isActive = true
        textView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        textView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textView.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        textView.alpha = 0.65
        if #available(iOS 13.0, *) {
            textView.textColor = .label
        } else {
            textView.textColor = .black
        }
        UIView.animate(withDuration: 0.5) {
            view.alpha = 1
            textView.alpha = 1
        }
    }
    
    func deleteUnnecessarySubviews() {
        for view in self.view.subviews {
            if let vu = view as? UIImageView{
                vu.removeFromSuperview()
            }
            if let text = view as? UILabel {
                text.removeFromSuperview()
            }
        }
    }
}



extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = viewModel!.numberOfRowsInTableView(forSubgroup: selectedSubgroup ?? 0)
        if numberOfRows == 0 && selectedGroup != nil{
            deleteUnnecessarySubviews()
            let dayType = viewModel?.getDayType()
            switch dayType {
            case .bussiness:
                showImageView(withImageName: "books", andText: "Сегодня пар нет, самое время отдохнуть")
            case .weekend:
                showImageView(withImageName: "books", andText: "Выходной, самое время отдохнуть")
            case .none:
                print("none")
            }
        }
        return numberOfRows
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

extension ScheduleViewController: UICollectionViewDataSource {

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

extension ScheduleViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        let date = cell.viewModel?.date
        viewModel?.setDate(date: date!, indexPath: indexPath)
        self.headerView.viewModel = viewModel!.headerViewViewModel()
        self.selectedDayView.viewModel = viewModel!.selectedDayViewViewModel()
        collectionView.reloadData()
        deleteUnnecessarySubviews()
        tableView.reloadData()
        refreshButton.tintColor = .black
        UIView.animate(withDuration: 0.15, animations: {
            self.refreshButton.transform = CGAffineTransform(rotationAngle: 0)
        })
    }

}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout {

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

extension ScheduleViewController: HeaderViewDelegate {
    
    func updateButtonTapped(completion: @escaping () -> Void) -> Bool {
        if selectedGroup != nil {
            if Reachability.shared.isConnectedToNetwork(){
                viewModel?.getTimetableData(forGroup: selectedGroup ?? "", updateCacheOrNot: true, completion: { [weak self] in
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.collectionView.reloadData()
                        self?.headerView.viewModel = self?.viewModel!.headerViewViewModel()
                        self?.selectedDayView.viewModel = self?.viewModel!.selectedDayViewViewModel()
                        completion()
                    }
                })
            } else {
                self.showErrorView(withMessage: "No internet coonection. Week number may be wrong!")
                return false
            }
            return true
        } else {
            self.showErrorView(withMessage: "Group is not selected. Please select your group!")
            return false
        }
        
    }
}

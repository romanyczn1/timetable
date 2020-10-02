//
//  GroupsViewControllerCell.swift
//  timetable
//
//  Created by Roman Bukh on 9/13/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class GroupsViewControllerCell : UITableViewCell {
    
    static let reuseId = "GroupsViewControllerCell"
    
    func showCellTapAnimation() {
        UIView.animate(withDuration: 0.1,
            animations: {
                self.myView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.myView.transform = CGAffineTransform.identity
                }
            })
    }
    
    var viewModel: GroupsViewControllerCellViewModelType? {
        willSet(viewModel){
            self.groupDataLabel.text = "\(viewModel?.groupName ?? "fuck off") / \(viewModel?.subgroupNumb ?? 9999)"
            if viewModel!.isMain {
                myView.layer.borderWidth = 1
                myView.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
            }
        }
    }
    
    let shadowView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = #colorLiteral(red: 0.9231548309, green: 0.923309505, blue: 0.9231344461, alpha: 1)
        }
        view.layer.cornerRadius = 20
        return view
    }()
    
    let groupDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.alpha = 0.65
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(shadowView)
        self.shadowView.addSubview(myView)
        
        shadowView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7).isActive = true

        myView.leadingAnchor.constraint(equalTo: self.shadowView.leadingAnchor, constant: 0).isActive = true
        myView.trailingAnchor.constraint(equalTo: self.shadowView.trailingAnchor, constant: 0).isActive = true
        myView.topAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 0).isActive = true
        myView.bottomAnchor.constraint(equalTo: self.shadowView.bottomAnchor, constant: 0).isActive = true
        
        myView.addSubview(groupDataLabel)
        
        groupDataLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15).isActive = true
        groupDataLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        groupDataLabel.topAnchor.constraint(equalTo: self.myView.topAnchor, constant: 10).isActive = true
        groupDataLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        groupDataLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        myView.layer.borderWidth = 0
        myView.layer.borderColor = UIColor.clear.cgColor
    }
}

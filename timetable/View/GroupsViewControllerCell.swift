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
    
    var viewModel: GroupsViewControllerCellViewModelType? {
        willSet(viewModel){
            self.groupDataLabel.text = "\(viewModel?.groupName ?? "fuck off") / \(viewModel?.subgroupNumb ?? 9999)"
            if viewModel!.isMain {
                myView.layer.borderWidth = 5
                myView.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
            }
        }
    }
    
    let myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    let groupDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.alpha = 0.65
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
    
        self.contentView.addSubview(myView)
        
        myView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 7).isActive = true
        myView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -7).isActive = true
        myView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7).isActive = true
        myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7).isActive = true
        
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

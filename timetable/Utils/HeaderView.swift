//
//  HeaderView.swift
//  timetable
//
//  Created by Roman Bukh on 9/11/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class HeaderView: UIView {
    
    var viewModel: HeaderViewViewModelType? {
        willSet(viewModel){
            self.weekdayNameLabel.text = viewModel?.weekdayName
            self.weekNumberLabel.text = viewModel?.weekNumber
        }
    }
    
    let weekdayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.alpha = 0.65
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            // Fallback on earlier versions
        }
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weekNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.alpha = 0.65
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            // Fallback on earlier versions
        }
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpConstraints()
        if #available(iOS 13.0, *) {
            self.backgroundColor = .secondarySystemBackground
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func setUpConstraints(){
        addSubview(weekdayNameLabel)
        addSubview(weekNumberLabel)
        
        weekdayNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        weekdayNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7 + statusBarHeight).isActive = true
        weekdayNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        weekdayNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        
        weekNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        weekNumberLabel.topAnchor.constraint(equalTo: self.weekdayNameLabel.bottomAnchor, constant: 3).isActive = true
        weekNumberLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        weekNumberLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 3).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

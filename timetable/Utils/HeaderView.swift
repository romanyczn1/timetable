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
        }
    }
    
    let weekdayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.alpha = 0.65
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        addSubview(weekdayNameLabel)
        
        weekdayNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        weekdayNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        weekdayNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        weekdayNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SelectedDayView.swift
//  timetable
//
//  Created by Roman Bukh on 9/20/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class SelectedDayView: UIView {
    
    var viewLeadingConstraint: NSLayoutConstraint!
    
    var viewModel: SelectedDayViewViewModelType? {
        willSet(viewModel){
            let day = viewModel?.weekdayNumber
            viewLeadingConstraint.constant = CGFloat(day!)*(frame.width / 7)
            myView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
    lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.03088182025, green: 0.5741170049, blue: 0.7236190438, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        myView.isHidden = true
        viewLeadingConstraint = myView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(myView)
        
        myView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        myView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        myView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        viewLeadingConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  HeaderView.swift
//  timetable
//
//  Created by Roman Bukh on 9/11/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderViewDelegate: class {
    func updateButtonTapped(completion: @escaping () -> Void) -> Bool
}

final class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
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
            label.textColor = .black
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
            label.textColor = .black
        }
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "arrow.clockwise")
            button.setImage(image, for: UIControl.State.normal)
        } else {
            let image = UIImage(named: "refresh")
            button.setImage(image, for: UIControl.State.normal)
        }
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutIfNeeded()
        if #available(iOS 13.0, *) {
            self.backgroundColor = .secondarySystemBackground
        } else {
            self.backgroundColor = #colorLiteral(red: 0.9518182874, green: 0.951977551, blue: 0.9517973065, alpha: 1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(weekdayNameLabel)
        addSubview(weekNumberLabel)
        addSubview(updateButton)
        
        weekdayNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        weekdayNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7 + statusBarHeight).isActive = true
        weekdayNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        weekdayNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        
        weekNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        weekNumberLabel.topAnchor.constraint(equalTo: self.weekdayNameLabel.bottomAnchor, constant: 3).isActive = true
        weekNumberLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        weekNumberLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 3).isActive = true
        
        updateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7).isActive = true
        updateButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: statusBarHeight / 2).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc private func updateButtonTapped() {
        updateButton.isUserInteractionEnabled = false
        updateButton.alpha = 0.5
        if delegate?.updateButtonTapped(completion: {
            self.updateButton.isUserInteractionEnabled = true
            self.updateButton.alpha = 1
        }) == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.updateButton.isUserInteractionEnabled = true
                self.updateButton.alpha = 1
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

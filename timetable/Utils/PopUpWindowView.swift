//
//  PopUpWindow.swift
//  timetable
//
//  Created by Roman Bukh on 9/23/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class PopUpWindowView: UIView {
    
    override var bounds: CGRect {
        didSet{
            popupView.layer.cornerRadius = bounds.height / 2
        }
    }
    
    let popupView = UIView(frame: CGRect.zero)
    let popupTitle = UILabel(frame: CGRect.zero)
    let popupText = UILabel(frame: CGRect.zero)
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .clear
        
        switch traitCollection.userInterfaceStyle {
            case .dark:
                popupView.backgroundColor = #colorLiteral(red: 0.5210646391, green: 0.9959064126, blue: 0.5883926153, alpha: 1)
            case .light:
                popupView.backgroundColor = #colorLiteral(red: 0.7257048488, green: 0.9854747653, blue: 0.678380549, alpha: 1)
            default:
                break
        }
        popupView.layer.masksToBounds = true
        // Popup Title
        if #available(iOS 13.0, *) {
            popupTitle.textColor = .label
        } else {
            popupTitle.textColor = .black
        }
        popupTitle.backgroundColor = .clear
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont.systemFont(ofSize: 21.0, weight: .medium)
        popupTitle.numberOfLines = 0
        popupTitle.textAlignment = .center
        
        popupView.addSubview(popupTitle)
        
        // Add the popupView(box) in the PopUpWindowView (semi-transparent background)
        addSubview(popupView)
        
        
        // PopupView constraints
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            popupView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            popupView.topAnchor.constraint(equalTo: self.topAnchor),
            popupView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        
        // PopupTitle constraints
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 5),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -5),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 0),
            popupTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            popupTitle.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: 0)
            ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

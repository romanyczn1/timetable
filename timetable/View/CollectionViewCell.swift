//
//  DateCell.swift
//  timetable
//
//  Created by Roman Bukh on 8/31/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

class DateCell: UICollectionViewCell {

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "28"
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let weekdayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "ВТ"
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let reuseId = "DateCell"
    var viewModel: CollectionViewCellViewModelType? {
        willSet(viewModel){
            dateLabel.text = viewModel?.weekdayDate
            weekdayNameLabel.text = viewModel?.weekdayName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.addSubview(dateLabel)
        self.addSubview(weekdayNameLabel)
        dateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 7).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weekdayNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        weekdayNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 7).isActive = true
        weekdayNameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

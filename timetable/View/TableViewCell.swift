//
//  LessonCell.swift
//  timetable
//
//  Created by Roman Bukh on 8/31/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

class LessonCell: UITableViewCell {
    
    static let reuseId = "LessonCell"
    
    var viewModel: TableViewCellViewModelType? {
        didSet{
            lessonNameLabel.text = viewModel?.lessonName
            lessonTimeLabel.text = viewModel?.lessonTime
            teacherFirstAndMiddleNameLabel.text = "\(viewModel?.tacherFirstName ?? "")  \(viewModel?.teacherMiddleName ?? "")"
            teacherLastNameLabel.text = viewModel?.teacherLastName
            lessonAuditoryLabel.text = viewModel?.lessonAuditory
            lessonTypeLabel.text = viewModel?.lessonTypeName
            self.myView.backgroundColor = viewModel?.cellColor
        }
    }
    
    let myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    let lessonNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.alpha = 0.65
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lessonTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HiraginoSans-W6", size: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacherFirstAndMiddleNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacherLastNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lessonTypeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0.65
        return view
    }()
    
    let lessonTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Medium", size: 13)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    let lessonAuditoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HiraginoSans-W6", size: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacherImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 20
        return imageView
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
        
        myView.addSubview(lessonNameLabel)
        myView.addSubview(lessonTimeLabel)
        myView.addSubview(teacherImageView)
        myView.addSubview(lessonTypeView)
        myView.addSubview(lessonTypeLabel)
        myView.addSubview(lessonAuditoryLabel)
        myView.addSubview(teacherFirstAndMiddleNameLabel)
        myView.addSubview(teacherLastNameLabel)
        
        lessonNameLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15).isActive = true
        lessonNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        lessonNameLabel.topAnchor.constraint(equalTo: self.myView.topAnchor, constant: 15).isActive = true
        lessonNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        
        lessonTimeLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15).isActive = true
        lessonTimeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        lessonTimeLabel.topAnchor.constraint(equalTo: self.lessonNameLabel.bottomAnchor, constant: 0).isActive = true
        lessonTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        
        teacherImageView.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15).isActive = true
        teacherImageView.topAnchor.constraint(equalTo: self.lessonTimeLabel.bottomAnchor, constant: 12).isActive = true
        teacherImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        teacherImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        teacherImageView.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -15).isActive = true
        
        lessonTypeView.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -15).isActive = true
        lessonTypeView.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        lessonTypeView.centerYAnchor.constraint(equalTo: self.lessonNameLabel.centerYAnchor, constant: 0).isActive = true
        lessonTypeView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        
        lessonTypeLabel.trailingAnchor.constraint(equalTo: self.lessonTypeView.trailingAnchor, constant: -7).isActive = true
        lessonTypeLabel.leadingAnchor.constraint(equalTo: self.lessonTypeView.leadingAnchor, constant: 7).isActive = true
        lessonTypeLabel.topAnchor.constraint(equalTo: self.lessonTypeView.topAnchor, constant: 1.5).isActive = true
        lessonTypeLabel.bottomAnchor.constraint(equalTo: self.lessonTypeView.bottomAnchor, constant: -1.5).isActive = true
        
        lessonAuditoryLabel.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -15).isActive = true
        lessonAuditoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        lessonAuditoryLabel.topAnchor.constraint(equalTo: self.lessonTypeLabel.bottomAnchor, constant: 5).isActive = true
        lessonAuditoryLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        
        teacherFirstAndMiddleNameLabel.leadingAnchor.constraint(equalTo: self.teacherImageView.trailingAnchor, constant: 9).isActive = true
        teacherFirstAndMiddleNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        teacherFirstAndMiddleNameLabel.topAnchor.constraint(equalTo: self.teacherImageView.topAnchor, constant: 0).isActive = true
        teacherFirstAndMiddleNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        teacherLastNameLabel.leadingAnchor.constraint(equalTo: self.teacherImageView.trailingAnchor, constant: 9).isActive = true
        teacherLastNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        teacherLastNameLabel.bottomAnchor.constraint(equalTo: self.teacherImageView.bottomAnchor, constant: 0).isActive = true
        teacherLastNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.teacherImageView.image = nil
//        self.teacherImageView.isHidden = true
    }
}

extension LessonCell: TableViewCellViewModelDelegate {
    func updateImage(image: UIImage) {
//        self.teacherImageView.isHidden = false
        self.teacherImageView.image = image
    }
    
    
}

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
            teacherNameLabel.text = viewModel?.teacherName
            lessonAuditoryLabel.text = viewModel?.lessonAuditory
            teacherImageView.image = viewModel?.teacherImage
            self.myView.backgroundColor = viewModel?.cellColor
        }
    }
    
    let myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let lessonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lessonTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacherNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lessonAuditoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 25
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
        myView.addSubview(teacherNameLabel)
        myView.addSubview(lessonAuditoryLabel)
        myView.addSubview(teacherImageView)
        
        teacherImageView.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 10).isActive = true
        teacherImageView.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor).isActive = true
        teacherImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        teacherImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        lessonNameLabel.leadingAnchor.constraint(equalTo: self.teacherImageView.trailingAnchor, constant: 7).isActive = true
        lessonNameLabel.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -7).isActive = true
        lessonNameLabel.topAnchor.constraint(equalTo: self.myView.topAnchor, constant: 1).isActive = true
        lessonNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        lessonTimeLabel.leadingAnchor.constraint(equalTo: self.teacherImageView.trailingAnchor, constant: 7).isActive = true
        lessonTimeLabel.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -7).isActive = true
        lessonTimeLabel.topAnchor.constraint(equalTo: self.lessonNameLabel.bottomAnchor, constant: 1).isActive = true
        lessonTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        teacherNameLabel.leadingAnchor.constraint(equalTo: self.teacherImageView.trailingAnchor, constant: 7).isActive = true
        teacherNameLabel.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -7).isActive = true
        teacherNameLabel.topAnchor.constraint(equalTo: self.lessonTimeLabel.bottomAnchor, constant: 1).isActive = true
        teacherNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        lessonAuditoryLabel.leadingAnchor.constraint(equalTo: self.teacherImageView.trailingAnchor, constant: 7).isActive = true
        lessonAuditoryLabel.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -7).isActive = true
        lessonAuditoryLabel.topAnchor.constraint(equalTo: self.teacherNameLabel.bottomAnchor, constant: 1).isActive = true
        lessonAuditoryLabel.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor, constant: -1).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LessonCell: TableViewCellViewModelDelegate {
    func updateImage(image: UIImage?) {
        self.teacherImageView.image = image
    }
    
    
}

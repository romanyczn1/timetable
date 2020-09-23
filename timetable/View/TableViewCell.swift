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
    var teacherImageViewHeight: NSLayoutConstraint!
    var teacherImageViewToLessonName: NSLayoutConstraint!
    
    var viewModel: TableViewCellViewModelType? {
        didSet{
            lessonNameLabel.text = viewModel?.lessonName
            lessonTimeLabel.text = viewModel?.lessonTime
            teacherFirstAndMiddleNameLabel.text = "\(viewModel?.tacherFirstName ?? "")  \(viewModel?.teacherMiddleName ?? "")"
            if viewModel?.tacherFirstName == nil {
                teacherImageView.isHidden = true
                teacherLastNameLabel.isHidden = true
                teacherFirstAndMiddleNameLabel.isHidden = true
                teacherImageViewHeight.constant = 0
                teacherImageViewToLessonName.constant = 0
                self.layoutIfNeeded()
            } else {
                teacherImageViewToLessonName.constant = 12
                teacherImageViewHeight.constant = 40
                self.layoutIfNeeded()
            }
            teacherLastNameLabel.text = viewModel?.teacherLastName
            lessonAuditoryLabel.text = viewModel?.lessonAuditory
            lessonTypeLabel.text = viewModel?.lessonTypeName
            subgroupNumbLabel.textColor = viewModel?.firstCellColor
            if viewModel?.userSubgroupNumb != 0 || viewModel?.subgroupNumb == 0 {
                subgroupNumbView.isHidden = true
                subgroupNumbLabel.isHidden = true
            }
            subgroupNumbLabel.text = "\(viewModel?.subgroupNumb ?? 9999)"
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
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let gradient: CAGradientLayer = {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.cornerRadius = 20
        gradient.locations = [0.2 , 1.9]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
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
    
    let subgroupNumbView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 7.5
        view.alpha = 0.65
        return view
    }()
    
    let subgroupNumbLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 13)
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        teacherImageViewToLessonName = teacherImageView.topAnchor.constraint(equalTo: self.lessonTimeLabel.bottomAnchor, constant: 12)
        teacherImageViewHeight = teacherImageView.heightAnchor.constraint(equalToConstant: 40)
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

        myView.addSubview(lessonNameLabel)
        myView.addSubview(lessonTimeLabel)
        if !teacherImageView.isHidden {
            myView.addSubview(teacherImageView)
            myView.addSubview(teacherFirstAndMiddleNameLabel)
            myView.addSubview(teacherLastNameLabel)
        }
        myView.addSubview(lessonTypeView)
        myView.addSubview(lessonTypeLabel)
        myView.addSubview(lessonAuditoryLabel)
        myView.addSubview(subgroupNumbView)
        myView.addSubview(subgroupNumbLabel)

        lessonNameLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15).isActive = true
        lessonNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        lessonNameLabel.topAnchor.constraint(equalTo: self.myView.topAnchor, constant: 10).isActive = true
        let lessonNameLabelHeightAnhcor = lessonNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15)
        lessonNameLabelHeightAnhcor.priority = UILayoutPriority(rawValue: 999)
        lessonNameLabelHeightAnhcor.isActive = true
        
        subgroupNumbView.leadingAnchor.constraint(equalTo: self.lessonNameLabel.trailingAnchor, constant: 10).isActive = true
        subgroupNumbView.widthAnchor.constraint(greaterThanOrEqualToConstant: 3).isActive = true
        subgroupNumbView.centerYAnchor.constraint(equalTo: self.lessonNameLabel.centerYAnchor, constant: 0).isActive = true
        subgroupNumbView.heightAnchor.constraint(greaterThanOrEqualToConstant: 3).isActive = true

        subgroupNumbLabel.trailingAnchor.constraint(equalTo: self.subgroupNumbView.trailingAnchor, constant: -4).isActive = true
        subgroupNumbLabel.leadingAnchor.constraint(equalTo: self.subgroupNumbView.leadingAnchor, constant: 4).isActive = true
        subgroupNumbLabel.topAnchor.constraint(equalTo: self.subgroupNumbView.topAnchor, constant: 2).isActive = true
        subgroupNumbLabel.bottomAnchor.constraint(equalTo: self.subgroupNumbView.bottomAnchor, constant: -2).isActive = true

        lessonTimeLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15).isActive = true
        lessonTimeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        lessonTimeLabel.topAnchor.constraint(equalTo: self.lessonNameLabel.bottomAnchor, constant: 0).isActive = true
        let lessonTimeLabelHeightAnchor = lessonTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15)
        lessonTimeLabelHeightAnchor.priority = UILayoutPriority(rawValue: 999)
        lessonTimeLabelHeightAnchor.isActive = true
        
        teacherImageView.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15).isActive = true
        teacherImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        teacherImageView.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -10).isActive = true
        teacherImageViewToLessonName.priority = UILayoutPriority(rawValue: 999)
        teacherImageViewToLessonName.isActive = true
        teacherImageViewHeight.priority = UILayoutPriority(rawValue: 999)
        teacherImageViewHeight.isActive = true

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

        if viewModel != nil {
            gradient.colors = [viewModel!.firstCellColor.cgColor , viewModel!.secondCellColor.cgColor]
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
            self.myView.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.teacherImageView.image = nil
        self.subgroupNumbView.isHidden = false
        self.subgroupNumbLabel.isHidden = false
        teacherImageView.isHidden = false
        teacherLastNameLabel.isHidden = false
        teacherFirstAndMiddleNameLabel.isHidden = false
    }
}

extension LessonCell: TableViewCellViewModelDelegate {
    func updateImage(image: UIImage) {
        self.teacherImageView.image = image
    }
    
    
}

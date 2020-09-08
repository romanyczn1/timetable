//
//  TableViewCellViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 8/31/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewCellViewModelDelegate: class {
    func updateImage(image: UIImage?)
}

class TableViewCellViewModel: TableViewCellViewModelType {
    
    var lessonType: String
    var lessonTime: String
    var lessonName: String
    var lessonAuditory: String
    var teacherName: String
    var cellColor: UIColor
    var teacherImage: UIImage?
    
    weak var delegate: TableViewCellViewModelDelegate?
    
    init(forLesson lesson: Lesson, forIndexPath idnexPath: IndexPath) {
        self.lessonType = lesson.lessonType
        self.lessonTime = lesson.lessonTime
        self.lessonName = lesson.subject
        if lesson.auditory != [] {
            self.lessonAuditory = lesson.auditory[0]
        }else {
            self.lessonAuditory = ""
        }
        switch lessonType {
        case "ЛК" : self.cellColor = #colorLiteral(red: 0.3764705882, green: 1, blue: 0, alpha: 1)
        case "ПЗ" : self.cellColor = #colorLiteral(red: 1, green: 1, blue: 0.2, alpha: 1)
        case "ЛР" : self.cellColor = #colorLiteral(red: 1, green: 0.2, blue: 1, alpha: 1)
        default:
            self.cellColor = UIColor.white
        }
        if lesson.employee != [] {
            self.teacherName = lesson.employee[0].fio
            if lesson.employee[0].photoLink != nil {
                downloadImage(from: URL(string: lesson.employee[0].photoLink!)!)
            }
        }else {
            self.teacherName = ""
        }
    }
    
    private func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.teacherImage = UIImage(data: data)
                self?.delegate?.updateImage(image: (self?.teacherImage) ?? nil)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

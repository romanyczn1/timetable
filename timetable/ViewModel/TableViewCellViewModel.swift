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
    func updateImage(image: UIImage)
}

class TableViewCellViewModel: TableViewCellViewModelType {
    
    var lessonType: String
    var lessonTypeName: String
    var lessonTime: String
    var lessonName: String
    var lessonAuditory: String?
    var teacherName: String?
    var teacherLastName: String?
    var tacherFirstName: String?
    var teacherMiddleName: String?
    var cellColor: UIColor
    
    weak var delegate: TableViewCellViewModelDelegate?
    
    init(forLesson lesson: Lesson, forIndexPath idnexPath: IndexPath) {
        self.lessonType = lesson.lessonType
        self.lessonTime = lesson.lessonTime
        self.lessonName = lesson.subject
        if lesson.auditory != [] {
            self.lessonAuditory = lesson.auditory[0]
        }
        switch lessonType {
        case "ЛК" :
            self.cellColor = #colorLiteral(red: 0.3647058824, green: 0.7450980392, blue: 0.6666666667, alpha: 1)
            self.lessonTypeName = "Лекция"
        case "ПЗ" :
            self.cellColor = #colorLiteral(red: 1, green: 1, blue: 0.4784313725, alpha: 1)
            self.lessonTypeName = "Практическое занятие"
        case "ЛР" :
            self.cellColor = #colorLiteral(red: 0.6117647059, green: 0.5450980392, blue: 0.8392156863, alpha: 1)
            self.lessonTypeName = "Лабараторная"
        default:
            self.cellColor = UIColor.white
            self.lessonTypeName = ""
        }
        if lesson.employee != [] {
            self.teacherName = lesson.employee[0].fio
            self.teacherLastName = lesson.employee[0].lastName
            self.teacherMiddleName = lesson.employee[0].middleName
            self.tacherFirstName = lesson.employee[0].firstName
            if lesson.employee[0].photoLink != nil {
                downloadImage(fromURL: lesson.employee[0].photoLink!)
            } else {
                downloadImage(fromURL: "https://cdn0.iconfinder.com/data/icons/circus-jocker-faces-avatars/66/10-512.png")
            }
        } else if lesson.employee == [] {
            downloadImage(fromURL: "https://cdn0.iconfinder.com/data/icons/circus-jocker-faces-avatars/66/10-512.png")
        }
    }
    
    private func downloadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async() { [weak self] in
                    self?.delegate?.updateImage(image: image)
                    return
                }
            } else {
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async() { [weak self] in
                            self?.delegate?.updateImage(image: image)
                        }
                    }
                }.resume()
            }
        }
    }
}

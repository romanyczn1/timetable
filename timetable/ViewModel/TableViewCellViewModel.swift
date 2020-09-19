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
    var firstCellColor: UIColor
    var secondCellColor: UIColor
    var subgroupNumb: Int
    var userSubgroupNumb: Int
    
    weak var delegate: TableViewCellViewModelDelegate?
    
    init(forLesson lesson: Lesson, forIndexPath idnexPath: IndexPath, subgroup: Int, traitCollection: UITraitCollection) {
        self.lessonType = lesson.lessonType
        self.lessonTime = lesson.lessonTime
        self.lessonName = lesson.subject
        if lesson.auditory != [] {
            self.lessonAuditory = lesson.auditory[0]
        }
        switch traitCollection.userInterfaceStyle {
        case .dark:
            switch lessonType {
            case "ЛК" :
                self.firstCellColor = UIColor(red: 0, green: 0.87, blue: 0.79, alpha: 1)
                self.secondCellColor = .white
                self.lessonTypeName = "Лекция"
            case "ПЗ" :
                self.firstCellColor = UIColor(red: 1, green: 1, blue: 0.42, alpha: 1)
                self.secondCellColor = .white
                self.lessonTypeName = "Практическое занятие"
            case "ЛР" :
                self.firstCellColor = UIColor(red: 0.61, green: 0.545, blue: 0.84, alpha: 1)
                self.secondCellColor = .white
                self.lessonTypeName = "Лабараторная"
            default:
                self.firstCellColor = .white
                self.secondCellColor = .white
                self.lessonTypeName = ""
            }
        case .light:
            switch lessonType {
            case "ЛК" :
                self.firstCellColor = #colorLiteral(red: 0.8549210102, green: 1, blue: 1, alpha: 1)
                self.secondCellColor = .white
                self.lessonTypeName = "Лекция"
            case "ПЗ" :
                self.firstCellColor = #colorLiteral(red: 1, green: 1, blue: 0.9000951338, alpha: 1)
                self.secondCellColor = .white
                self.lessonTypeName = "Практическое занятие"
            case "ЛР" :
                self.firstCellColor = #colorLiteral(red: 1, green: 0.9229993081, blue: 1, alpha: 1)
                self.secondCellColor = .white
                self.lessonTypeName = "Лабараторная"
            default:
                self.firstCellColor = .white
                self.secondCellColor = .white
                self.lessonTypeName = ""
            }
        default:
            self.firstCellColor = .white
            self.secondCellColor = .white
            self.lessonTypeName = ""
        }
        self.subgroupNumb = lesson.numSubgroup
        self.userSubgroupNumb = subgroup
        if lesson.employee != [] {
            self.teacherName = lesson.employee[0].fio
            self.teacherLastName = lesson.employee[0].lastName
            self.teacherMiddleName = lesson.employee[0].middleName
            self.tacherFirstName = lesson.employee[0].firstName
            if lesson.employee[0].photoLink != nil {
                downloadImage(fromURL: lesson.employee[0].photoLink!)
            }
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

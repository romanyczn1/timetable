//
//  ViewControllerViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerViewModel: ViewControllerViewModelType {
    
    var fetcher: DataFetcher?
    var timetable: Timetable?
    
    var currentWeekday: Int
    
    var date = MyDate(day: 0, month: 0, year: 0, selectedWeekday: 0)
    var selectedSchoolWeek: Int?
    
    let numberOfDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init(){
        let date = Date()
        let calendar = Calendar.current
        self.currentWeekday = calendar.component(.weekday, from: date)
        self.date.month = calendar.component(.month, from: date)
        self.date.year = calendar.component(.year, from: date)
        self.date.day = calendar.component(.day, from: date)
        if self.currentWeekday == 1 {
            self.date.selectedWeekday = 6
        } else {
            self.date.selectedWeekday = self.currentWeekday - 2
        }
    }
    
    func getTimetableData(forGroup group: String, completion: @escaping () -> Void) {
        fetcher = NetworkDataFetcher()
        fetcher!.getTimetable(forGroupId: group) { [weak self] (timetable, error) in
            if error != nil { return }
            self?.timetable = timetable
            self?.selectedSchoolWeek = timetable?.currentWeekNumber
            completion()
        }
    }
    
    func rightSwipeOccured() {
        self.date.selectedWeekday -= 1
        self.date.day -= 1
        if self.date.day == 0 {
            self.date.month -= 1
            if self.date.month == 0 {
                self.date.year -= 1
                self.date.month = 12
            }
            self.date.day = self.numberOfDaysInMonths[date.month - 1]
        }
        if self.date.selectedWeekday == -1 {
            self.date.selectedWeekday = 6
            self.selectedSchoolWeek! -= 1
            if self.selectedSchoolWeek == 0 {
                self.selectedSchoolWeek = 4
            }
        }
    }
    
    func leftSwipeOccured() {
        self.date.selectedWeekday += 1
        self.date.day += 1
        if self.date.day > numberOfDaysInMonths[self.date.month - 1] {
            self.date.month += 1
            if self.date.month ==  13 {
                self.date.month = 1
                self.date.year += 1
            }
            self.date.day = 1
        }
        if self.date.selectedWeekday == 7 {
            self.date.selectedWeekday = 0
            self.selectedSchoolWeek! += 1
            if self.selectedSchoolWeek == 5 {
                self.selectedSchoolWeek = 1
            }
        }
    }
    
    func setDate(date: MyDate, indexPath: IndexPath) {
        self.date.day = date.day
        self.date.month = date.month
        self.date.year = date.year
        self.date.selectedWeekday = date.selectedWeekday
    }
    
    func numberOfRowsInTableView(forSubgroup subgroup: Int) -> Int {
        if date.selectedWeekday != 6 {
            let filteredLessons = timetable?.schedules[date.selectedWeekday].schedule.filter({ (lesson) -> Bool in
                lesson.weekNumber.contains(selectedSchoolWeek!) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subgroup)
            })
            return filteredLessons?.count ?? 0
        }
        return 0
    }
    
    func numberOfRowsInCollectionView() -> Int {
        return 7
    }
    
    
    func collectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType? {
        return CollectionViewCellViewModel.init(forIndexPath: indexPath, forDate: MyDate.init(day: self.date.day, month: self.date.month, year: self.date.year, selectedWeekday: self.date.selectedWeekday))
    }
    
    func tableViewCellViewModel(forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let lesson = getNeededLesson(forSubgroup: subGroup, forIndexPath: indexPath)
        return TableViewCellViewModel.init(forLesson: lesson, forIndexPath: indexPath)
    }
    
    private func getNeededLesson(forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath) -> Lesson {
        let weekFilteredLesson = self.timetable?.schedules[date.selectedWeekday].schedule.filter({ (lesson) -> Bool in
            lesson.weekNumber.contains(selectedSchoolWeek!) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subGroup)
        })
        return weekFilteredLesson![indexPath.row]
    }
    
    
}

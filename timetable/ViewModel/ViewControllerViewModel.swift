//
//  ViewControllerViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

class ViewControllerViewModel: ViewControllerViewModelType {
    
    var fetcher: DataFetcher?
    var timetable: Timetable?
    
    let currentDay: Int
    let currentWeekday: Int
    let currentMonth: Int
    let currentYear: Int
    
    let weekdayNames = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
    
    init(){
        let date = Date()
        let calendar = Calendar.current
        self.currentDay = calendar.component(.day, from: date)
        self.currentWeekday = calendar.component(.weekday, from: date)
        self.currentMonth = calendar.component(.month, from: date)
        self.currentYear = calendar.component(.year, from: date)
    }
    
    func getTimetableData(forGroup group: String, completion: @escaping () -> Void) {
        fetcher = NetworkDataFetcher()
        fetcher!.getTimetable(forGroupId: group) { [weak self] (timetable, error) in
            if error != nil { return }
            self?.timetable = timetable
            completion()
        }
    }
    
    func getCurrentWeekday() -> Int {
        if self.currentWeekday == 1 {
            return 6
        } else {
            return self.currentWeekday - 2
        }
    }
    
    func numberOfRowsInTableView(forWeekday weekday: Int, forSubgroup subgroup: Int) -> Int {
        let filteredLessons = timetable?.schedules[weekday].schedule.filter({ (lesson) -> Bool in
            lesson.weekNumber.contains(timetable!.currentWeekNumber) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subgroup)
        })
        return filteredLessons?.count ?? 0
    }
    
    func numberOfRowsInCollectionView() -> Int {
        return weekdayNames.count
    }
    
    
    func collectionViewCellViewModel() -> CollectionViewCellViewModelType? {
        return nil
    }
    
    func tableViewCellViewModel(forWeekday weekday: Int, forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let lesson = getNeededLesson(forWeekday: weekday, forIndexPath: indexPath)
        return TableViewCellViewModel.init(forLesson: lesson, forIndexPath: indexPath)
    }
    
    private func getNeededLesson(forWeekday weekday: Int, forIndexPath indexPath: IndexPath) -> Lesson {
        let weekFilteredLesson = self.timetable?.schedules[weekday].schedule.filter({ (lesson) -> Bool in
            lesson.weekNumber.contains(timetable!.currentWeekNumber)
        })
        return weekFilteredLesson![indexPath.row]
    }
    
    
}

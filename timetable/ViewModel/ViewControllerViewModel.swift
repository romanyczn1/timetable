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
    var currentWeekday: Int
    let currentMonth: Int
    let currentYear: Int
    
    var selectedWeekday: Int
    var selectedWeek: Int?
    
    let weekdayNames = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
    
    init(){
        let date = Date()
        let calendar = Calendar.current
        self.currentDay = calendar.component(.day, from: date)
        self.currentWeekday = calendar.component(.weekday, from: date)
        self.selectedWeekday = currentWeekday
        self.currentMonth = calendar.component(.month, from: date)
        self.currentYear = calendar.component(.year, from: date)
    }
    
    func setSelectedWeekday(selectedWeekday: Int, completion: @escaping (Int) -> Void) {
        if selectedWeekday == 7 {
            self.selectedWeekday = 0
            self.selectedWeek! += 1
            if self.selectedWeek == 5 {
                self.selectedWeek = 1
            }
            completion(self.selectedWeekday)
        } else if selectedWeekday == -1{
            self.selectedWeekday = 6
            self.selectedWeek! -= 1
            if self.selectedWeek == 0 {
                self.selectedWeek = 4
            }
            completion(self.selectedWeekday)
        } else {
            completion(selectedWeekday)
        }
    }
    
    func getTimetableData(forGroup group: String, completion: @escaping () -> Void) {
        fetcher = NetworkDataFetcher()
        fetcher!.getTimetable(forGroupId: group) { [weak self] (timetable, error) in
            if error != nil { return }
            self?.timetable = timetable
            self?.selectedWeek = timetable?.currentWeekNumber
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
        if weekday != 6 {
            let filteredLessons = timetable?.schedules[weekday].schedule.filter({ (lesson) -> Bool in
                lesson.weekNumber.contains(selectedWeek!) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subgroup)
            })
            return filteredLessons?.count ?? 0
        }
        return 0
    }
    
    func numberOfRowsInCollectionView() -> Int {
        return weekdayNames.count
    }
    
    
    func collectionViewCellViewModel() -> CollectionViewCellViewModelType? {
        return nil
    }
    
    func tableViewCellViewModel(forWeekday weekday: Int, forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let lesson = getNeededLesson(forWeekday: weekday, forSubgroup: subGroup, forIndexPath: indexPath)
        return TableViewCellViewModel.init(forLesson: lesson, forIndexPath: indexPath)
    }
    
    private func getNeededLesson(forWeekday weekday: Int, forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath) -> Lesson {
        let weekFilteredLesson = self.timetable?.schedules[weekday].schedule.filter({ (lesson) -> Bool in
            lesson.weekNumber.contains(selectedWeek!) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subGroup)
        })
        return weekFilteredLesson![indexPath.row]
    }
    
    
}

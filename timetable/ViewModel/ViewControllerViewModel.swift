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
    
    var currentWeekday: Int
    
    var selectedMonth: Int
    var selectedYear: Int
    var selectedDay: Int
    var selectedWeekday: Int
    var selectedSchoolWeek: Int?
    
    init(){
        let date = Date()
        let calendar = Calendar.current
        self.currentWeekday = calendar.component(.weekday, from: date)
        selectedMonth = calendar.component(.month, from: date)
        selectedYear = calendar.component(.year, from: date)
        selectedDay = calendar.component(.day, from: date)
        if self.currentWeekday == 1 {
            self.selectedWeekday = 6
        } else {
            self.selectedWeekday = self.currentWeekday - 2
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
        selectedWeekday -= 1
        if selectedWeekday == -1 {
            self.selectedWeekday = 6
            self.selectedSchoolWeek! -= 1
            if self.selectedSchoolWeek == 0 {
                self.selectedSchoolWeek = 4
            }
        }
    }
    
    func leftSwipeOccured() {
        selectedWeekday += 1
        if selectedWeekday == 7 {
            self.selectedWeekday = 0
            self.selectedSchoolWeek! += 1
            if self.selectedSchoolWeek == 5 {
                self.selectedSchoolWeek = 1
            }
        }
    }
    
    func numberOfRowsInTableView(forSubgroup subgroup: Int) -> Int {
        if selectedWeekday != 6 {
            let filteredLessons = timetable?.schedules[selectedWeekday].schedule.filter({ (lesson) -> Bool in
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
        return CollectionViewCellViewModel.init(forIndexPath: indexPath, forDate: MyDate.init(month: 1, year: 1, day: 1))
    }
    
    func tableViewCellViewModel(forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let lesson = getNeededLesson(forSubgroup: subGroup, forIndexPath: indexPath)
        return TableViewCellViewModel.init(forLesson: lesson, forIndexPath: indexPath)
    }
    
    private func getNeededLesson(forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath) -> Lesson {
        let weekFilteredLesson = self.timetable?.schedules[selectedWeekday].schedule.filter({ (lesson) -> Bool in
            lesson.weekNumber.contains(selectedSchoolWeek!) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subGroup)
        })
        return weekFilteredLesson![indexPath.row]
    }
    
    
}

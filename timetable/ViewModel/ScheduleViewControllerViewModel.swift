//
//  ScheduleViewControllerViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ScheduleViewControllerViewModel: ScheduleViewControllerViewModelType {
    
    var fetcher: DataFetcher?
    var timetable: Timetable?
    var fetchedResultsController: NSFetchedResultsController<Groupa>
    var coreDataStack: CoreDataStack
    
    var date = MyDate(day: 0, month: 0, year: 0, selectedWeekday: 0)
    var startDate = MyDate(day: 0, month: 0, year: 0, selectedWeekday: 0)
    var selectedSchoolWeek: Int?
    
    var numberOfDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init(fetchedResultsController: NSFetchedResultsController<Groupa>, coreDataStack: CoreDataStack){
        
        //        do {
        //            try coreDataStack.managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "TimetableCD")))
        //            try coreDataStack.managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "StudentGroupCD")))
        //            try coreDataStack.managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "ScheduleCD")))
        //            try coreDataStack.managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "LessonCD")))
        //            try coreDataStack.managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "EmployeeCD")))
        //            try coreDataStack.managedContext.save()
        //        } catch {
        //            print(error)
        //        }
        
        let date = Date()
        let calendar = Calendar.current
        let currentWeekday = calendar.component(.weekday, from: date)
        self.date.month = calendar.component(.month, from: date)
        self.date.year = calendar.component(.year, from: date)
        self.date.day = calendar.component(.day, from: date)
        if currentWeekday == 1 {
            self.date.selectedWeekday = 6
        } else {
            self.date.selectedWeekday = currentWeekday - 2
        }
        self.startDate = self.date
        self.fetchedResultsController = fetchedResultsController
        self.coreDataStack = coreDataStack
    }
    
    func tryGetSelectedGroup(complition: @escaping (String?, Int?) -> Void) {
        var hasMainGroup = false
        fetchedResultsController.fetchedObjects?.map({ (group) in
            if group.isMain == true {
                complition(group.groupName, Int(group.subgroupNumb))
                hasMainGroup = true
            }
        })
        if !hasMainGroup {
            complition(nil, nil)
        }
        
    }
    
    func clearTimetable() {
        self.timetable = nil
    }
    
    func getTimetableData(forGroup group: String, updateCacheOrNot: Bool, completion: @escaping () -> Void) {
        var dispatchTime = DispatchTime(uptimeNanoseconds: 0)
        if fetcher == nil {
            fetcher = NetworkDataFetcher()
        }
        if updateCacheOrNot {
            fetcher?.updateTimetableCache(forGroupId: group)
            dispatchTime = DispatchTime.now() + .seconds(1)
        }
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.fetcher!.getTimetable(forGroupId: group) { [weak self] (timetable, error) in
                if error != nil {
                    print("ERROR LOADING WEEK NUMBER \(String(describing: error?.localizedDescription))")
                }
                self?.timetable = timetable
                self?.saveTimetableOnDevice()
                self?.goToStartDate {
                    completion()
                }
            }
        }
        
    }
    
    func getCurrentWeekNumber(updateCacheOrNot: Bool, completion: @escaping () -> Void) {
        var dispatchTime = DispatchTime(uptimeNanoseconds: 0)
        if fetcher == nil {
            fetcher = NetworkDataFetcher()
        }
        if updateCacheOrNot {
            fetcher?.updateWeekNumberCache()
            dispatchTime = DispatchTime.now() + .seconds(1)
        }
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.fetcher?.getCurrentWeekNumber(response: { (curWeekNumb, error) in
                if error != nil {
                    print("ERROR LOADING WEEK NUMBER \(String(describing: error?.localizedDescription))")
                }
                if curWeekNumb != nil {
                    self.selectedSchoolWeek = curWeekNumb
                    completion()
                }
            })
        }
    }
    
    func refreshDate(completion: @escaping () -> Void) { //loading startDate and updating weekNumber if needed
        let date = Date()
        let calendar = Calendar.current
        let currentWeekday = calendar.component(.weekday, from: date)
        var tempDate = MyDate(day: 0, month: 0, year: 0, selectedWeekday: 0)
        tempDate.month = calendar.component(.month, from: date)
        tempDate.year = calendar.component(.year, from: date)
        tempDate.day = calendar.component(.day, from: date)
        if currentWeekday == 1 {
            tempDate.selectedWeekday = 6
        } else {
            tempDate.selectedWeekday = currentWeekday - 2
        }
        if tempDate != self.startDate {
            self.startDate = tempDate
            if Reachability.shared.isConnectedToNetwork() {
                self.getCurrentWeekNumber(updateCacheOrNot: true, completion: { completion()})
            } else {
                print("NO INTERNET CONNECTION HELLO")
                self.getCurrentWeekNumber(updateCacheOrNot: false, completion: { completion()})
            }
        } else {
            self.getCurrentWeekNumber(updateCacheOrNot: false, completion: { completion()})
        }
    }
    
    func goToStartDate(completion: @escaping () -> Void) {
        refreshDate { completion() }
        self.date = self.startDate
    }
    
    func getDayType() -> DayType {
        if 0...4 ~= self.date.selectedWeekday{
            return .bussiness
        } else {
            return .weekend
        }
    }
    
    func rightSwipeOccured() {
        if self.date.year % 4 == 0 {
            numberOfDaysInMonths[1] = 29
        } else {
            numberOfDaysInMonths[1] = 28
        }
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
            if timetable != nil {
                self.selectedSchoolWeek! -= 1
                if self.selectedSchoolWeek == 0 {
                    self.selectedSchoolWeek = 4
                }
            }
        }
    }
    
    func leftSwipeOccured() {
        if self.date.year % 4 == 0 {
            numberOfDaysInMonths[1] = 29
        } else {
            numberOfDaysInMonths[1] = 28
        }
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
            if timetable != nil {
                self.selectedSchoolWeek! += 1
                if self.selectedSchoolWeek == 5 {
                    self.selectedSchoolWeek = 1
                }
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
        if timetable != nil && selectedSchoolWeek != nil{
            if date.selectedWeekday < (timetable?.schedules.count)! {
                if subgroup == 0 {
                    let filteredLessons = timetable?.schedules[date.selectedWeekday].schedule.filter({ (lesson) -> Bool in
                        lesson.weekNumber.contains(selectedSchoolWeek!)
                    })
                    return filteredLessons?.count ?? 0
                } else {
                    let filteredLessons = timetable?.schedules[date.selectedWeekday].schedule.filter({ (lesson) -> Bool in
                        lesson.weekNumber.contains(selectedSchoolWeek!) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subgroup)
                    })
                    return filteredLessons?.count ?? 0
                }
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func numberOfRowsInCollectionView() -> Int {
        return 7
    }
    
    func selectedDayViewViewModel() -> SelectedDayViewViewModelType? {
        return SelectedDayViewViewModel.init(forDate: date)
    }
    
    func headerViewViewModel() -> HeaderViewViewModelType? {
        return HeaderViewViewModel.init(forDate: date, selectedSchoolWeek: self.selectedSchoolWeek)
    }
    
    func collectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType? {
        return CollectionViewCellViewModel.init(forIndexPath: indexPath, forDate: date, realWorldDate: startDate)
    }
    
    func tableViewCellViewModel(forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath, traitCollection: UITraitCollection) -> TableViewCellViewModelType? {
        let lesson = getNeededLesson(forSubgroup: subGroup, forIndexPath: indexPath)
        return TableViewCellViewModel.init(forLesson: lesson, forIndexPath: indexPath, subgroup: subGroup, traitCollection: traitCollection)
    }
    
    private func getNeededLesson(forSubgroup subGroup: Int, forIndexPath indexPath: IndexPath) -> Lesson {
        if subGroup == 0 {
            let weekFilteredLesson = self.timetable?.schedules[date.selectedWeekday].schedule.filter({ (lesson) -> Bool in
                lesson.weekNumber.contains(selectedSchoolWeek!)
            })
            return weekFilteredLesson![indexPath.row]
        } else {
            let weekFilteredLesson = self.timetable?.schedules[date.selectedWeekday].schedule.filter({ (lesson) -> Bool in
                lesson.weekNumber.contains(selectedSchoolWeek!) && (lesson.numSubgroup == 0 || lesson.numSubgroup == subGroup)
            })
            return weekFilteredLesson![indexPath.row]
        }
    }
    
    private func saveTimetableOnDevice() {
        
        self.fetchedResultsController.fetchedObjects?.map({ (group) in
            if group.isMain == true {
                
                //Groupa entity
                let timeTableCD = TimetableCD.init(context: coreDataStack.managedContext)
                timeTableCD.currentWeekNumber	= Int16(self.timetable!.currentWeekNumber)
                timeTableCD.employee = self.timetable?.employee
                timeTableCD.todayDate = self.timetable?.todayDate
                
                group.timetable = timeTableCD
                
                //TimetableCD entity
                let studentGroupCD = StudentGroupCD.init(context: coreDataStack.managedContext)
                studentGroupCD.course = Int16((self.timetable?.studentGroup.course)!)
                studentGroupCD.name = self.timetable?.studentGroup.name
                
                group.timetable?.studentGroup = studentGroupCD
                
                
                for schedule in timetable!.schedules {
                    let scheduleCD = ScheduleCD.init(context: coreDataStack.managedContext)
                    scheduleCD.weekday = schedule.weekDay
                    for lesson in schedule.schedule {
                        let lessonCD = LessonCD.init(context: coreDataStack.managedContext)
                        lessonCD.auditory = lesson.auditory
                        lessonCD.endLessonTime = lesson.endLessonTime
                        lessonCD.lessonTime = lesson.lessonTime
                        lessonCD.lessonType = lesson.lessonType
                        lessonCD.numSubgroup = Int64(lesson.numSubgroup)
                        lessonCD.subject = lesson.subject
                        lessonCD.weekNumber = lesson.weekNumber
                        lessonCD.startLessonTime = lesson.startLessonTime
                        lessonCD.note = lesson.note
                        for employee in lesson.employee {
                            let employeeCD = EmployeeCD.init(context: coreDataStack.managedContext)
                            employeeCD.fio = employee.fio
                            employeeCD.firstName = employee.firstName
                            employeeCD.lastName = employee.lastName
                            employeeCD.middleName = employee.middleName
                            employeeCD.photoLink = employee.photoLink
                            lessonCD.addToEmployee(employeeCD)
                        }
                        scheduleCD.addToSchedule(lessonCD)
                    }
                    group.timetable?.addToScedules(scheduleCD)
                }
            }
        })
        
        coreDataStack.saveContext()
    }
}

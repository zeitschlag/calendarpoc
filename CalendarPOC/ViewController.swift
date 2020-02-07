//
//  ViewController.swift
//  CalendarPOC
//
//  Created by Nathan Mattes on 07.02.20.
//  Copyright © 2020 Nathan Mattes. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    
    let calendarView: JTACMonthView
    let monthFormatter: DateFormatter
    
    init() {
        
        calendarView = JTACMonthView(frame: .zero)
        calendarView.scrollDirection = .vertical
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .lightGray
        calendarView.scrollToDate(Date())
        calendarView.showsVerticalScrollIndicator = false
        
        monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        
        super.init(nibName: nil, bundle: nil)
        
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
        
        calendarView.register(DateHeader.self, forSupplementaryViewOfKind: DateHeader.reuseIdentifier, withReuseIdentifier: DateHeader.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(calendarView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let constraints = [
            calendarView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            calendarView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1.0),
            calendarView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: calendarView.trailingAnchor, multiplier: 1.0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: calendarView.bottomAnchor, multiplier: 1.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Today", style: .done, target: self, action: #selector(scrollToToday(_:)))
    }
    
    //MARK: - Actions
    
    @objc
    func scrollToToday(_ sender: Any) {
        calendarView.scrollToDate(Date())
    }
}

//MARK: - JTACMonthViewDataSource
extension ViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = Date(timeIntervalSinceNow: -60*60*24*365)
        let endDate = Date(timeIntervalSinceNow: 60*60*24*365)
        let gregorianCalendar = Calendar(identifier: .gregorian)
        
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       calendar: gregorianCalendar,
                                       firstDayOfWeek: .monday,
                                       hasStrictBoundaries: false)
    }
}

//MARK: - JTACMonthViewDelegate
extension ViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else {
            NSLog("This should never happen")
            assert(false)
        }
        
        configure(cell, withCellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendarView.dequeueReusableJTAppleCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as? DayCell else {
            NSLog("This should never happen")
            assert(false)
        }
        
        configure(cell, withCellState: cellState)
        return cell
    }
    
    private func configure(_ cell: DayCell, withCellState cellState: CellState) {
        cell.dateLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print(date)
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: DateHeader.reuseIdentifier, for: indexPath) as! DateHeader
        header.monthTitle.text = self.monthFormatter.string(from: range.start)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 40)
    }
}

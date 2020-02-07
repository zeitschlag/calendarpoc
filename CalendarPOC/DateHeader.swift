//
//  DateHeader.swift
//  CalendarPOC
//
//  Created by Nathan Mattes on 07.02.20.
//  Copyright © 2020 Nathan Mattes. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateHeader: JTACMonthReusableView {
    
    static let reuseIdentifier = "DateHeader"

    let monthTitle: UILabel
    
    override init(frame: CGRect) {
        monthTitle = UILabel(frame: .zero)
        monthTitle.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        addSubview(monthTitle)
        
        let constraints = [
            monthTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            monthTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        backgroundColor = .darkGray
        monthTitle.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

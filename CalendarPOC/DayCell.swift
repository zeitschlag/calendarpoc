//
//  DayCell.swift
//  CalendarPOC
//
//  Created by Nathan Mattes on 07.02.20.
//  Copyright © 2020 Nathan Mattes. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DayCell: JTACDayCell {
    static let reuseIdentifier = "CalendarCell"
    
    let dateLabel: UILabel
    
    override init(frame: CGRect) {
        
        dateLabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        contentView.addSubview(dateLabel)
        
        let constraints = [
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ViewController.swift
//  CalendarPOC
//
//  Created by Nathan Mattes on 07.02.20.
//  Copyright © 2020 Nathan Mattes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}


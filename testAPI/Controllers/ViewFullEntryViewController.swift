//
//  ViewFullEntryViewController.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import UIKit

final class ViewFullEntryViewController: UIViewController {
    
    var entry : String?
    
    @IBOutlet weak var entryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryLabel.text = entry
    }
}

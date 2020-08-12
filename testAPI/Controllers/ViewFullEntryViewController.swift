//
//  ViewFullEntryViewController.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import UIKit

class ViewFullEntryViewController: UIViewController {
    
    var entry : String?

    @IBOutlet weak var entryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        entryLabel.text = entry
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

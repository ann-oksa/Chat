//
//  ViewController.swift
//  Chat
//
//  Created by Anna Oksanichenko on 10.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func toChatVC(_ sender: UIButton) {
        performSegue(withIdentifier: "toChatVC", sender: nil)
    }
    
}


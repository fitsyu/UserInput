//
//  ViewController.swift
//  UserInput
//
//  Created by Fitsyu  on 20/06/19.
//  Copyright © 2019 Fitsyu . All rights reserved.
//

// API
// ================
// POST /coffee.shop/welcome?isItNecessary=<Bool>&cName=<String>&count=<Int>
// key isItNecessary
//  type = Bool
//  desc = determines whether a customer wants a coffee or not

// key cName
//  type = String
//  desc = customer name so we can write it on the coffee cup

// key count
//  type = Int
//  desc = the number of cups to make

// User AppDesign requirement
// ================
// Display it as Do you like a coffee?
// What is your name?
// How many cups do you want?

import UIKit

class ViewController: UIViewController, Presentation {
    
    func ask(about: String) {
        self.qLabel.text = about
    }
    
    func readAnswer() -> Bool {
        return qSwitch.isOn
    }
    
    func updateAnswer(with: String) {
        self.aLabel.text = with
    }
    // ==================================
    
    
    // q.. -> Question
    // a.. -> Answer
    @IBOutlet weak var qLabel: UILabel!
    @IBOutlet weak var qSwitch: UISwitch!
    @IBOutlet weak var aLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // system reaction setup
        qSwitch.addTarget(self, action: #selector(notify), for: .valueChanged)
        
        
        submitButton.addTarget(self, action: #selector(shout), for: .touchUpInside)
    }

    
    @objc func notify() {
        Coordinater.shared.doneInput()
    }

    
    @objc func shout() {
        Coordinater.shared.dumpInput()
    }
}


//
//  ViewController.swift
//  UserInput
//
//  Created by Fitsyu  on 20/06/19.
//  Copyright © 2019 Fitsyu . All rights reserved.
//

import UIKit


// POST /coffee.shop/welcome?isItNecessary=<Bool>
// key = isItNecessary
// type = bool

// Design requirement
// Display it as Do you like a coffee?








class ViewController: UIViewController, Presentation {
    
    // Conforming to protocol
    var model: Question<Bool>!
    
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
        
        
        // comlete the design requirement
        qLabel.text = model.displayName
        
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


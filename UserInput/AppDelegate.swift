//
//  AppDelegate.swift
//  UserInput
//
//  Created by Fitsyu  on 20/06/19.
//  Copyright © 2019 Fitsyu . All rights reserved.
//

import UIKit

// Model In
// Matching API key with Design Requirement
public class Question {
    
    var keyName: String     = "isItNecessary"
    var displayName: String = "Do you like a coffee?"
//    var type: T.Type = T.self
}


// Model Out
// A Template to fill in the blanks where we can also
// specify default answer in case it is not provided by user
public class Answer {
    
    var value: Bool? = false // optional with default
}


// View Blueprint
public protocol Presentation {
    
    func ask(about: String)
    
    func readAnswer() -> Bool
    
    func updateAnswer(with: String)
}



// The gatherer
class Coordinater {
    
    public var input: Question!
    public var presenter: Presentation!
    public var output: Answer = Answer()
    
    private var employee: CoordinaterEmployee = Worker()
    
    func start() {
        
        presenter.ask(about: input.displayName)
    }
    
    public func doneInput() {
        
        let inputRaw = presenter.readAnswer()
        // save
        self.output.value = inputRaw
        
        let formattedAnswer = employee.process(input: self.output.value!)
        presenter.updateAnswer(with: formattedAnswer)
    }
    
    public func dumpInput() {
        print(input.keyName, output.value ?? "")
    }
    
    // Instance
    private init() {}
    static private var _instance: Coordinater?
    static var shared: Coordinater {
        if Coordinater._instance == nil {
            Coordinater._instance = Coordinater()
        }
        
        return Coordinater._instance!
    }
}

protocol CoordinaterEmployee {
    
    func process(input: Bool) -> String
}

class Worker: CoordinaterEmployee {
    
    public func process(input: Bool) -> String {
        
        let output = input == true ? "Yes" : "Noooo!"
        return output
    }
}

// Launcher
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // model
        let question = Question()
        
        // presentation
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vx01       = storyboard.instantiateInitialViewController() as! ViewController
        
        
        // before we play
        window?.rootViewController = vx01
        window?.makeKeyAndVisible()
        
        
        // give me everything I need
        Coordinater.shared.input     = question
        Coordinater.shared.presenter = vx01 as Presentation
        
        // and I can start my work
        Coordinater.shared.start()
        
        return true
    }
}

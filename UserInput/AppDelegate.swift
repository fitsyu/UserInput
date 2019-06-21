//
//  AppDelegate.swift
//  UserInput
//
//  Created by Fitsyu  on 20/06/19.
//  Copyright © 2019 Fitsyu . All rights reserved.
//

import UIKit

// Model Out
public class Question {
    
    var keyName: String     = "isItNecessary"
    var displayName: String = "Do you like a coffee?"
//    var type: T.Type = T.self
}

// Model Out
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
    
    var input: Question!
    var presenter: Presentation!
    var output: Answer = Answer()
    
    func start() {
        
        presenter.ask(about: input.displayName)
    }
    
    public func doneInput() {
        
        let inputRaw = presenter.readAnswer()
        // save
        self.output.value = inputRaw
        
        let formattedAnswer = inputRaw ? "Yes" : "Nope"
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

//
//  AppDelegate.swift
//  UserInput
//
//  Created by Fitsyu  on 20/06/19.
//  Copyright © 2019 Fitsyu . All rights reserved.
//

import UIKit

// Launcher
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // model
        let question = Question<Bool>()
        
        // presentation
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vx01       = storyboard.instantiateInitialViewController() as! ViewController
        
        
        // before we play
        window?.rootViewController = vx01
        
        
        // let's play
        Coordinater.shared.model = question
        Coordinater.shared.presenter = vx01 as Presentation
        Coordinater.shared.start()
        
        return true
    }
}

// Model
public class Question<T> {
    
    var keyName: String     = "isItNecessary"
    var displayName: String = "Do you like a coffe?"
    var type: T.Type = T.self
}

// View Blueprint
public protocol Presentation {
    
    var model: Question<Bool>! { get set }
    
    func readAnswer() -> Bool
    
    func updateAnswer(with: String)
}

public class Answer {
    
    var question: Question<Bool>?
    var value: Bool?
}

// The gatherer
class Coordinater {
    
    var model: Question<Bool>!
    var presenter: Presentation!
    
    var answer: Answer = Answer()
    
    func start() {
        
        presenter.model = model
    }
    
    func doneInput() {
        
        let inputRaw = presenter.readAnswer()
        // save
        self.answer.value = inputRaw
        
        let formattedAnswer = inputRaw ? "Yes" : "Nope"
        presenter.updateAnswer(with: formattedAnswer)
    }
    
    public func dumpInput() {
        print(model.keyName, answer.value)
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

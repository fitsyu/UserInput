import UIKit

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
        
        let fillInBlank = Answer()
        fillInBlank.question = question
        
        
        // before we play
        window?.rootViewController = vx01
        window?.makeKeyAndVisible()
        
        
        // give me everything I need
        Coordinater.shared.input     = question
        Coordinater.shared.presenter = vx01 as Presentation
        Coordinater.shared.output    = fillInBlank
        
        // and I can start my work
        Coordinater.shared.start()
        
        return true
    }
 
    // simulate external trigger
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("ADEB")
        Coordinater.shared.doneInput()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("AWEF")
        Coordinater.shared.dumpOutput()
    }
    
}

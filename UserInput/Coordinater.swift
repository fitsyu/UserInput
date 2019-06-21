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
    public var output: Answer!
    
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
    
    public func dumpOutput() {
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

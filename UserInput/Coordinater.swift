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
        dump(output)
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

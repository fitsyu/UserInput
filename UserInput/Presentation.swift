// View Blueprint
public protocol Presentation {
    
    func ask(about: String)
    
    func readAnswer() -> Bool
    
    func updateAnswer(with: String)
}

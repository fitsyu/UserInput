protocol CoordinaterEmployee {
    
    func process(input: Bool) -> String
}

class Worker: CoordinaterEmployee {
    
    public func process(input: Bool) -> String {
        
        let output = input == true ? "Yes" : "Noooo!"
        return output
    }
}

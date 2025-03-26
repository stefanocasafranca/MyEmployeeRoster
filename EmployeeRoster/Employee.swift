
import Foundation


//Step 0: Define the Employee (Model) Blueprint to store "Name, Birthday and Type"
//Always start with a struct.
struct Employee {
    var name: String
    var dateOfBirth: Date
    var employeeType: EmployeeType //Requires it's own data type
    
}

//Step 1: Define ALL the Cases (Employee Types)
//Call the protocols: To loop through enum cases && To display user-friendly names
enum EmployeeType: CaseIterable, CustomStringConvertible {
    case exempt       // Soon: Exempt Full Time
    case nonExempt    // Soon: Non-exempt Full Time
    case partTime     // Soon: Part Time
    
// Step 2: Provide human-readable names for each type. This strings will Appear later in labels for E.ListTVC.swift
    var description: String {
        //FYI: var name is set to "description" because that is how protocols works...
        switch self {
        case .exempt:
            return "Exempt Full Time"
        case .nonExempt:
            return "Non-exempt Full Time"
        case .partTime:
            return "Part Time"
        }
    }
}



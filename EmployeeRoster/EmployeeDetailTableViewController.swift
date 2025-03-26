
import UIKit

/*
MVC Flow:
1. User interacts with the View (e.g. Main.storyboard).
2. The Controller (e.g. UIAnyViewController) handles the user action.
3. The Controller uses the Model's blueprint (e.g. Employee.swift) to create instances (actual objects stored in memory using let/var).
   - Only the in-memory objects (the instances of the model) can be updated or replaced during runtime.
4. The Controller updates or replaces these in-memory objects with new data.
5. The Controller then updates the View with the new data.
*/


// Step 1: Protocol to send saved Employee data back to the list controller (E.ListTVC).
// When an employee is saved in this screen, the delegate method is called.
protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

// Step 2: EmployeeDetailTableViewController is the Controller in MVC.
// It manages the view for adding/editing an employee (e.g. from Main.storyboard)
// and connects user input to the model defined in Employee.swift.
class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, DatePickerCellDelegate {

    // MARK: Step 3 Outlets UI Connections
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet var dobDatePicker: UIDatePicker!

    // Step 4: Variables to track data and delegate
    // Delegate to pass data back to the list controller.
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    // Holds the employee and employeeType instances being edited or created.
    var employee: Employee?
    var employeeType: EmployeeType?

  
    //Step 5:Control whether to show/hide the date picker
    var isEditingBirthday: Bool = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        updateSaveButtonState()
    }
    
    // MARK: - UI Update Methods (COMMENT EACH LINE AND UNDERSTAND THE UT UPDATES LABELS)
    // Step 6: Fill "View" with Employee data if editing
    func updateView() {
        if let employee = employee {
            // Editing an existing employee: show current data.
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            // Adding a new employee: set a default title.
            navigationItem.title = "New Employee"
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func updateSaveButtonState() {
        // Enable the Save button only if the name field is not empty.
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        // Validate that the name field is not empty.
        guard let name = nameTextField.text else { return }
        
        // Create a new Employee instance using data from the view.
        // NOTE: Currently, dateOfBirth is set to the current date and employeeType to .exempt.
        // Consider reading actual values from the date picker and a selection control.
        let employee = Employee(name: name, dateOfBirth: Date(), employeeType: .exempt)
        
        // Send the employee back to the list controller using the delegate.
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        // Clear the employee data.
        // The actual dismissal is handled by the storyboard's unwind segue.
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        // Update the Save button state as the user types.
        updateSaveButtonState()
    }
    
    // MARK: - DatePickerCellDelegate
    // Called when the date in the DatePicker cell changes; updates the dobLabel.
    func datePickerCell(_ cell: DatePickerCell, didChangeDate date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dobLabel.text = formatter.string(from: date)
    }
    
    // MARK: - Unused / Alternate Code
    /*
    // Alternative approach for toggling date picker visibility:
    var isDOBvisible: Bool = true {
        didSet {
            // This would hide or show the date picker cell based on the flag.
            // Note: 'dobDatePicker' here represents an IndexPath, not a UI element.
            // A different approach is needed to hide the actual cell.
            dobDatePicker.isHidden = !isDOBvisible
        }
    }
    */
}

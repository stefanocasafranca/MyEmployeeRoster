//
//  DatePickerCell.swift
//  EmployeeRoster
//
//  Created by Stefano Casafranca on 3/23/25.
//

import UIKit

// MARK: BEFORE ANYTHING...
//Before this Cocoa file existed --> Added a Cell, Dropped Date Picker into the cell and set it to Wheel. Add constraints and set Row Height to 216 instead of 44. (So the Wheel is visible)


// MARK: Why this file exists? --> It's just a template for when yMakes a Reusable Cell that contains a UIDatePicker
//First --> Change the cell "Custom Class" to this file name (DatePickerCell)

// CUSTOM delegate protocol == Sets the contract to inform for date updates
protocol DatePickerCellDelegate: AnyObject {
    //This method gets called when the date picker’s value changes
    // MARK: VALUE CHANGES 1
    func datePickerCell(_ cell: DatePickerCell, didChangeDate date: Date)
}

// DatePickerCell encapsulates all the behavior and UI for a table view cell that contains a UIDatePicker.
// It manages the date picker's setup and communicates any changes via a delegate.
class DatePickerCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Delegate
    // The delegate property holds a reference to the PROTOCOL you previously defined.
    // Allow the cell to notify another object (typically a view controller) when the date changes.
    // It is declared 'weak' to avoid retain cycles and ensure proper memory management.
    weak var delegate: DatePickerCellDelegate?
    
    // awakeFromNib() is called when the cell is loaded from the storyboard or nib file.
    // It's the ideal place to perform one-time setup tasks.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Add a target-action to the datePicker so that the dateChanged(_:) method is called whenever its value changes.
        // MARK: VALUE CHANGES 2
        // MARK: - Binding UI Event + Event Handler "@objc"
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Event Handling
    // MARK: VALUE CHANGES 3
    // This method is triggered when the UIDatePicker's value changes.
    // It calls the delegate method to pass the new date back to the delegate (e.g., a view controller).
    @objc private func dateChanged(_ picker: UIDatePicker) {
        delegate?.datePickerCell(self, didChangeDate: picker.date) // Notify the delegate with the updated date.
    }
}

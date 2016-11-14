//
//  CardViewController.swift
//  Trello
//
//  Created by Events on 11/12/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var card: Card? = nil
    var list: List? = nil
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        
        if let card = card {
            nameTextField.text = card.name
            descriptionTextField.text = card.description
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text!
            let description = descriptionTextField.text!
            card = Card(name: name, description: description, id: "", list_id: list!.id)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
}


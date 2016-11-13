//
//  ViewController.swift
//  Trello
//
//  Created by Events on 11/12/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var card: Card = Card(name: "Test Card", description: "Test Description", id: "1231413", list_id: "53421jk")
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        descriptionTextView.delegate = self
    }
    
    @IBAction func saveCard(sender: UIButton) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        card.name = textField.text!
    }
    
}


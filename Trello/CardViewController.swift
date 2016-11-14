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
        print(list!.id)
        if let card = card {
            print(card.id)
            print(card.name)
            print(card.description)
            
            nameTextField.text = card.name
            descriptionTextField.text = card.description
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text!
            let description = descriptionTextField.text!
            if card != nil {
                TrelloAPI.sharedInstance.updateTrelloCardById(card!.id, name: name, desc: description, id_list: list!.id, onCompletion: { (json) in
                    self.card!.name = json["name"].stringValue
                    self.card!.description = json["desc"].stringValue
                })
            } else {
                print("CreateCard")
                TrelloAPI.sharedInstance.createTrelloCard(name, desc: description, id_list: list!.id, onCompletion: { (json) in
                    print(json)
                    self.card = Card(json: json, list_id: self.list!.id)
                    print(self.card!.name)
                    self.list!.cards.append(self.card!)
                })
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
}


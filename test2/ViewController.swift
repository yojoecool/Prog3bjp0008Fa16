//
//  ViewController.swift
//  test2
//
//  Created by Bridges Penn on 11/16/16.
//  Copyright © 2016 Bridges Penn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var conditionField: UITextField!
    @IBOutlet weak var optionsField: UITextView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var car: Car?
    var keyboardHeight: CGFloat = 0
    
    @IBAction func onTapGesureRecognize(sender: AnyObject) {
        yearTextField.resignFirstResponder()
        makeTextField.resignFirstResponder()
        modelField.resignFirstResponder()
        conditionField.resignFirstResponder()
        optionsField.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.view.frame.origin.y -= keyboardHeight
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                if self.view.frame.origin.y == 0
                {
                    keyboardHeight = keyboardSize.height
                    //self.view.frame.origin.y -= keyboardSize.height
                }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (backButton === sender) {
            let year: Int = Int(yearTextField.text!)!
            let make: String = makeTextField.text!
            let model: String = modelField.text!
            let condition: Int = Int(conditionField.text!)!
            let options: String = optionsField.text!
            
            car = Car(year: year, make: make, model: model, cond: condition, options: options)
        }
        
        else if (cancelButton === sender) {
            let isPresentingInAddCarMode = presentingViewController is UINavigationController
            
            if isPresentingInAddCarMode {
                let year: Int = 2016
                let make: String = "New Car"
                let model: String = "New Model"
                let condition: Int = 5
                let options: String = ""
                
                car = Car(year: year, make: make, model: model, cond: condition, options: options)
            }
            
            else {
                navigationController!.popViewControllerAnimated(true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.optionsField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        if let car = car {
            yearTextField.text = String(car.Year)
            makeTextField.text = car.Make
            modelField.text = car.Model
            conditionField.text = String(car.Condition)
            optionsField.text = car.Options
        }
        else {
            yearTextField.text = "2016"
            makeTextField.text = "New Car"
            modelField.text = "New Model"
            conditionField.text = "5"
            optionsField.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


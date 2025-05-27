//
//  ViewController.swift
//  Calculator
//
//  Created by Melisa Şimşek on 27.05.2025.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var secondNumber: UITextField!
    @IBOutlet weak var firstNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up text field delegates
        firstNumber.delegate = self
        secondNumber.delegate = self
        
        // Add tap gesture to dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate method to dismiss keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNumber {
            secondNumber.becomeFirstResponder()
        } else if textField == secondNumber {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // Check if input is numeric and show alert if not
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow backspace
        if string.isEmpty {
            return true
        }
        
        // Check if the input is numeric
        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
        let characterSet = CharacterSet(charactersIn: string)
        
        if !allowedCharacters.isSuperset(of: characterSet) {
            // Show alert for non-numeric input
            let alert = UIAlertController(title: "Uyarı",
                                        message: "Lütfen sadece sayı giriniz",
                                        preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true)
            return false
        }
        
        return true
    }

    @IBAction func plusButton(_ sender: UIButton) {
        if let firstNum = Double(firstNumber.text ?? ""),
           let secondNum = Double(secondNumber.text ?? "") {
            let sum = firstNum + secondNum
            result.text = "Sonuç: " + String(sum)
        } else {
            result.text = "Lütfen sayı giriniz"
        }
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        if let firstNum = Double(firstNumber.text ?? ""),
           let secondNum = Double(secondNumber.text ?? "") {
            let difference = firstNum - secondNum
            result.text = "Sonuç: " + String(difference)
        } else {
            result.text = "Lütfen sayı giriniz"
        }
    }
   
    
    @IBAction func DividedBy(_ sender: UIButton) {
        if let firstNum = Double(firstNumber.text ?? ""),
           let secondNum = Double(secondNumber.text ?? "") {
            if secondNum != 0 {
                let quotient = firstNum / secondNum
                result.text = "Sonuç: " + String(quotient)
            } else {
                result.text = "Sıfıra bölünemez"
            }
        } else {
            result.text = "Lütfen sayı giriniz"
        }
    }
    
    @IBAction func MultipliedBy(_ sender: UIButton) {
        if let firstNum = Double(firstNumber.text ?? ""),
           let secondNum = Double(secondNumber.text ?? "") {
            let product = firstNum * secondNum
            result.text = "Sonuç: " + String(product)
        } else {
            result.text = "Lütfen sayı giriniz"
        }
    }
}


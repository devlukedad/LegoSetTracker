//
//  ViewController.swift
//  LegoSetTracker
//
//  Created by Luke Kollen on 6/25/18.
//  Copyright © 2018 Luke Kollen. All rights reserved.
//

import UIKit


class AddLegoSetViewController: UIViewController, UITextFieldDelegate {
    
    // Luke, Jon, & Mike Kollen are cool

    @IBOutlet weak var setNameTextField: UITextField!
    @IBOutlet weak var setNumberTextField: UITextField!
    @IBOutlet weak var pieceCountTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "Picture")
        pieceCountTextField.delegate = self
        setNumberTextField.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowed = "0123456789"
        let allowedcharsset = CharacterSet(charactersIn: allowed)
        let typed = CharacterSet(charactersIn: string)
        return allowedcharsset.isSuperset(of: typed)
    }

    @IBAction func cancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       
    }
    @IBAction func saveLegoSet(_ sender: Any) {
        
        let setName = setNameTextField.text ?? ""
        var setNumber = Int64(setNumberTextField.text!)
        var pieceCount = Int64(pieceCountTextField.text!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let legoSet = LegoSet(context: context)
        legoSet.legoSetId = UUID().uuidString
        legoSet.pieceCount = Int32(pieceCount!)
        legoSet.setNumber = Int32(setNumber!)
        legoSet.setName = setName
        
        do {
            try context.save()
        } catch let error {
            print("could not save because of \(error)")
        }
        
        dismiss(animated: true, completion: nil)
    }
    

}


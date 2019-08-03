//
//  addEvaluation.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 01/08/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import Foundation
import  UIKit
import CoreData

class addChild: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate {
    
    var context : NSManagedObjectContext?
    
    
    @IBOutlet var childName: UITextField!
    
    
    @IBOutlet var childBirthday: UIDatePicker!
    
    
    @IBOutlet var childPhoto: UIImageView!
    
    
    @IBOutlet var basse: UIImageView!
    
    
    var pickerPhotoButton = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        childPhoto.layer.cornerRadius = 48
        childPhoto.clipsToBounds = true
        
        basse.layer.cornerRadius = 48
        basse.clipsToBounds = true
        
        self.childName.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    
    func saveChild() {
        let child = NSEntityDescription.insertNewObject(forEntityName: "Crianca", into: context!) as! Crianca
        child.id = UUID()
        
        child.nome = childName.text
        
        child.aniversario = childBirthday.date as NSDate
        
        let temp:String = UUID().uuidString
        
        guard let imageName = temp as? String else { fatalError("Invalid Message Name!") }
        
        guard let image = childPhoto.image as? UIImage else { fatalError("Invalid Image") }
        
        saveImage(imageName: imageName, image: image)
        child.foto = imageName
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
    
    
    func saveImage(imageName: String, image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
    }

    
    @IBAction func cadastrarButtonClicked(_ sender: Any) {
        saveChild()
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            return print("Error")
            
        }
        
        
        childPhoto.image = image
        
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Adicionar foto da criança", message: nil, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.pickerPhotoButton.delegate = self
                self.pickerPhotoButton.sourceType = .camera
                self.pickerPhotoButton.allowsEditing = false
                self.present(self.pickerPhotoButton, animated: true, completion: nil)
                
            }
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Galeria", style: UIAlertAction.Style.default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                self.pickerPhotoButton.delegate = self
                self.pickerPhotoButton.sourceType = .photoLibrary
                self.pickerPhotoButton.allowsEditing = false
                self.present(self.pickerPhotoButton, animated: true, completion: nil)
                
            }
            
        }))
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.sourceRect = (sender as AnyObject).frame
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        
    }
    
}

//
//  addChild.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 22/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Photos

class addEvaluation: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
   
    var currentCrianca : Crianca!
    
let numero: [String] = ["0.0", "0.5", "1.0", "1.5", "2.0", "2.5", "3.0", "3.5", "4.0", "4.5", "5.0"]

    @IBOutlet var addPhoto: UIImageView!
    
    
    @IBOutlet var addPhotoButton: UIButton!
    var pickerPhotoButton = UIImagePickerController()
    
    
    @IBOutlet var base: UIImageView!
    
    
    @IBOutlet var addPickerFeliz: UIPickerView!
    
    
    @IBOutlet var addPickerIrritado: UIPickerView!
    
    
    @IBOutlet var addPickerTriste: UIPickerView!
    
    
    @IBOutlet var addPickerAmoroso: UIPickerView!
    
    
    @IBOutlet var registrarButton: UIButton!
    
    
    var context : NSManagedObjectContext?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPickerFeliz.dataSource = self
        addPickerFeliz.delegate = self
        
        addPickerTriste.dataSource = self
        addPickerTriste.delegate = self
        
        
        
        addPickerIrritado.dataSource = self
        addPickerIrritado.delegate = self
        
        addPickerAmoroso.dataSource = self
        addPickerAmoroso.delegate = self
        
        
        pickerPhotoButton.delegate = self
//        checkPermission()
        
        base.layer.cornerRadius = 48
        base.clipsToBounds = true
        
        addPhoto.layer.cornerRadius = 48
        base.clipsToBounds = true
        
        
        
        
        
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numero.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numero[row]
        
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name:"Charter-Black", size: 17)
        label.textColor = #colorLiteral(red: 0.9159615636, green: 0.2577577233, blue: 0.4256287217, alpha: 1)
        label.text =  numero[row]
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            
            return 20
        }
    
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addPhotoButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Adicionar foto de hoje da criança", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { (action) in
//            self.present(alert, animated: true, completion: nil)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.pickerPhotoButton.delegate = self
                self.pickerPhotoButton.sourceType = .camera
                self.pickerPhotoButton.allowsEditing = false
                self.present(self.pickerPhotoButton, animated: true, completion: nil)
                
            }
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Galeria", style: UIAlertAction.Style.default, handler: { (action) in
//            self.present(alert, animated: true, completion: nil)
            
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
    
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            return print("Error")
            
        }
        
        
        addPhoto.image = image
        
        
    }
    
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        createEvaluation()
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func createEvaluation () {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let evaluation = NSEntityDescription.insertNewObject(forEntityName: "Avaliacao", into: context!) as! Avaliacao
        evaluation.id = UUID()
        
        let felizEvaluation = Float(addPickerFeliz.selectedRow(inComponent: 0))
        evaluation.feliz = felizEvaluation/2
        
        
        let amorosoEvaluation = Float(addPickerAmoroso.selectedRow(inComponent: 0))
        evaluation.amoroso = amorosoEvaluation/2
        
        let irritadoEvaluation = Float(addPickerIrritado.selectedRow(inComponent: 0))
        evaluation.irritado = irritadoEvaluation/2
        
        let tristeEvaluation = Float(addPickerTriste.selectedRow(inComponent: 0))
        evaluation.triste = tristeEvaluation/2
        
        evaluation.dataDoDia = Date() as NSDate
        
        let imageName = UUID().uuidString
        
        guard let image = addPhoto.image else { fatalError("Invalid Image") }
        
        saveImage(imageName: imageName, image: image)
        evaluation.foto = imageName
        
//        fazer a relação de 1 -> muitos e muitos -> 1
        currentCrianca.addToRelationshipCriancaAvaliacao(evaluation)
        evaluation.relationshipAvaliacaoCrianca = currentCrianca
        
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
    
    
}


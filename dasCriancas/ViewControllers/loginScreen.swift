//
//  loginScreen.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 20/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//
import Foundation
import UIKit
import CoreData
import Photos

class loginScreen: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var parentPhoto: UIImageView!
    
    
    @IBOutlet var parentName: UITextField!
    
    
    @IBOutlet var pickerPhotoButton: UIButton!
    var picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        parentName.delegate = self
        parentName.autocapitalizationType = .sentences
        
        parentPhoto.image = parentPhoto.image?.circleMask
        
        checkPermission()
        
    }
    
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
        
    }
    
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "tabScreen")
//        self.dismiss(animated: true, completion: nil)
        self.present(vc, animated: true, completion: nil)
        
    }
    

    @IBAction func pickerPhotoButtonClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            present(picker, animated: true, completion: nil)
            
        }
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            return print("Error")
            
        }
    
        
        parentPhoto.image = image
        
       
    }
    
}
    








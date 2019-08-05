//
//  paisScreen.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 28/06/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class paisScreen: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var context : NSManagedObjectContext?
    var crianca : Crianca?
    
    var criancasCollection = [Crianca]()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createChildren()
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.criancasCollection.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showEvaluations", sender: self.criancasCollection[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEvaluations"){
            let crianca  = sender as! Crianca
            let displayVC = segue.destination as! evaluationScreen
            displayVC.sentCrianca = crianca
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "childCell", for: indexPath) as? ChildCell {
            return makeCell(cell: cell, indexPath: indexPath)
        }
        
        return UICollectionViewCell()
    }

    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }

    
    func createChildren() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Crianca")
        request.returnsObjectsAsFaults = false
        if let context = context{
            do{
                let result = try context.fetch(request)
                criancasCollection = []
                for data in result as! [NSManagedObject]{
                    criancasCollection.append(data as! Crianca)
                }
                
            }catch{
                fatalError("404 - Non Entity")
            }
        }
        collectionView.reloadData()
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.9, height: self.view.frame.size.height * 0.725) // tamanho celula
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func go (sender: exButton) {
        let alert = UIAlertController(title: "Descadastrar criança", message: "Você deseja mesmo descadastrar essa criança?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: { _ in }))
        
        alert.addAction(UIAlertAction(title: "Descadastrar", style: .destructive, handler: { (action) in self.context?.delete((sender.celula as? ChildCell)!.crianca!)
            self.criancasCollection.remove(at: (sender.celula as! ChildCell).criancaIndex!)
            self.collectionView.reloadData()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.saveContext()
            
        }))
        
        
        
        
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.sourceRect = (sender as AnyObject).frame
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        
    }
    
    
    
    
    
    func makeCell(cell:ChildCell, indexPath:IndexPath)-> ChildCell{
        cell.crianca = criancasCollection[indexPath.row]
        
        cell.parentVC = self
        
        cell.criancaIndex = indexPath.row
        
        cell.collectionView = collectionView
        
        cell.criancaId = criancasCollection[indexPath.row].id
        
        cell.childName.text = criancasCollection[indexPath.row].nome
        
        cell.getDataBirthday = criancasCollection[indexPath.row].aniversario as Date?
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        cell.childBirthday.text = formatter.string(for: criancasCollection[indexPath.row].aniversario)
        
        cell.childPhoto.image = loadImageFromDiskWith(fileName: criancasCollection[indexPath.row].foto!)
        cell.childPhoto.layer.cornerRadius = 48
        cell.childPhoto.clipsToBounds = true
//        cell.plantImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cell.base.layer.cornerRadius = 48
        cell.base.clipsToBounds = true
        

        cell.deleteChildButton.imageView?.image = cell.deleteChildButton.imageView?.image?.circleMask
        cell.deleteChildButton.celula = cell
        cell.deleteChildButton.addTarget(self, action: #selector(go(sender:)), for: .touchUpInside)
        
        return cell
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                        maxLineSpacingForSectionAt section: Int) -> CGFloat {
//        return .0
    }
   
}

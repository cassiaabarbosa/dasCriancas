//
//  evaluationScreen.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 01/08/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class evaluationScreen: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var context : NSManagedObjectContext?
    var sentCrianca : Crianca! //crianca que mandei de la para aparecer o log
    var avaliacao: Avaliacao?
    
    var avaliacoesCollection = [Avaliacao]()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createEvaluations()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.avaliacoesCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "evaluationCell", for: indexPath) as? EvaluationCell {
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
    
    func createEvaluations() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Avaliacao")
        request.returnsObjectsAsFaults = false
        if let context = context{
            do{
                let result = try context.fetch(request)
                avaliacoesCollection = []
                for data in result as! [NSManagedObject]{
                    let aux = data as! Avaliacao
                    if(aux.relationshipAvaliacaoCrianca == self.sentCrianca){
                        avaliacoesCollection.append(data as! Avaliacao)
                    }
                    
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
        let alert = UIAlertController(title: "Apagar registro", message: "Você deseja mesmo apagar esse registro?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Apagar", style: .destructive, handler: { (action) in
            
            
            
            self.context?.delete((sender.celula as? EvaluationCell)!.avaliacao!)
            self.avaliacoesCollection.remove(at: (sender.celula as! EvaluationCell).avaliacaoIndex!)
            self.collectionView.reloadData()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.saveContext()
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: { _ in }))
        
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.sourceRect = (sender as AnyObject).frame
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        
    }
    
    func makeCell(cell:EvaluationCell, indexPath:IndexPath)-> EvaluationCell{
        cell.avaliacao = avaliacoesCollection[indexPath.row]
        
        cell.parentVC = self
        
        cell.avaliacaoIndex = indexPath.row
        
        cell.collectionView = collectionView
        
        cell.avaliacaoId = avaliacoesCollection[indexPath.row].id
        
        cell.childName.text = String(sentCrianca.nome!)
            
        cell.feliz.image? = cell.feliz.image!.circleMask
        
        cell.amoroso.image? = cell.amoroso.image!.circleMask
        
        cell.irritado.image? = cell.irritado.image!.circleMask
        
        cell.triste.image? = cell.triste.image!.circleMask
        
        cell.amorosoNumber.text = String(avaliacoesCollection[indexPath.row].amoroso)
        
        cell.felizNumber.text = String(avaliacoesCollection[indexPath.row].feliz)
        
        cell.irritadoNumber.text = String(avaliacoesCollection[indexPath.row].irritado)
        
        cell.tristeNumber.text = String(avaliacoesCollection[indexPath.row].triste)
        
        cell.todayChildPhoto.image = loadImageFromDiskWith(fileName: avaliacoesCollection[indexPath.row].foto!)
        
        cell.todayChildPhoto.layer.cornerRadius = 48
        cell.todayChildPhoto.clipsToBounds = true

        
        cell.base.layer.cornerRadius = 48
        cell.base.clipsToBounds = true
        
        
        cell.deleteChildButton.imageView?.image = cell.deleteChildButton.imageView?.image?.circleMask
        cell.deleteChildButton.celula = cell
        cell.deleteChildButton.addTarget(self, action: #selector(go(sender:)), for: .touchUpInside)
        
        cell.getDataEvaluation = avaliacoesCollection[indexPath.row].dataDoDia as Date?
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        cell.dataEvaluation.text = formatter.string(for: avaliacoesCollection[indexPath.row].dataDoDia)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddEvaluation"{
            let displayVC = segue.destination as! addEvaluation
            displayVC.currentCrianca = sentCrianca
        }
    }
    
}

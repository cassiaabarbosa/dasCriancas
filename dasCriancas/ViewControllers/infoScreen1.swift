//
//  infoScreen1.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 28/06/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

class infoScreen1: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    

    @IBOutlet var pageControl: UIPageControl!
    
    
    var slides: [slide] = [];
    
    
    
    var paisScreenImages: [UIImage] = [UIImage(named: "pS1")!, UIImage(named: "pS2")!, UIImage(named: "pS3")!, UIImage(named: "pS4")!, UIImage(named: "pS5")!, UIImage(named: "pS6")!, UIImage(named: "pS7")! ]
    
    
    var storyScreenImages: [UIImage] = [UIImage(named: "sS1")!, UIImage(named: "sS2")!, UIImage(named: "sS3")!, UIImage(named: "sS4")!, UIImage(named: "sS5")!]
    
    
    var relaxScreenImages: [UIImage] = [UIImage(named: "rS1")!, UIImage(named: "rS2")!, UIImage(named: "rS2")!, UIImage(named: "rS3")!, UIImage(named: "rS4")!, UIImage(named: "rS5")!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        
        slides[0].imagem.frame.size.width = self.view.frame.width * 0.6
        slides[0].imagem.frame.size.height = self.view.frame.height * 0.6
        slides[0].imagem.center.x = self.view.center.x
        slides[0].imagem.center.y = self.view.center.y * 1.34
        
        
        slides[1].imagem.frame.size.width = self.view.frame.width * 0.7
        slides[1].imagem.frame.size.height = self.view.frame.height * 0.6
        slides[1].imagem.center.x = self.view.center.x
        slides[1].imagem.center.y = self.view.center.y * 1.34
        
        
        slides[2].okButton.imageView?.image = slides[2].okButton.imageView?.image?.circleMask
        
        slides[2].imagem.frame.size.width = self.view.frame.width * 0.7
        slides[2].imagem.frame.size.height = self.view.frame.height * 0.55
        slides[2].imagem.center.x = self.view.center.x
        slides[2].imagem.center.y = self.view.center.y * 1.35
        
    }

    
    func createSlides() -> [slide ] {
        let slide1:slide = Bundle.main.loadNibNamed("slide", owner: self, options: nil)?.first as! slide
        slide1.descricao.text = "Pelo menos uma vez na semana, faça as sessões de relaxamento e crie uma história com sua criança. Em seguida, avalie como ela estava no dia. Os registros permanecerão a fim de você poder avaliar como sua criança está lidando com as emoções."
        slide1.descricao.adjustsFontForContentSizeCategory = true
        slide1.okButton.isHidden = true
        
        slide1.imagem.animationImages = paisScreenImages
        slide1.imagem.animationDuration = 5.25
        slide1.imagem.startAnimating()
        
        slide1.imagem.layer.cornerRadius = 10
        slide1.imagem.layer.borderWidth = 2.5
        slide1.imagem.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)

        slide1.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.8078431373, blue: 0.8352941176, alpha: 1)

        
        
        
        let slide2:slide = Bundle.main.loadNibNamed("slide", owner: self, options: nil)?.first as! slide
        slide2.descricao.text = "Inicie, ou continue a história, a partir das palavras que surgem toda vez que o balão é clicado. Essa interação entre as ideias dos pais e dos filhos auxilia a confiança mútua, além de estimular a imaginação da criança."
       
        slide2.descricao.adjustsFontForContentSizeCategory = true
        
        slide2.imagem.animationImages = storyScreenImages
        slide2.imagem.animationDuration = 3.75
        slide2.imagem.startAnimating()
        
        slide2.imagem.layer.cornerRadius = 10
        slide2.imagem.layer.borderWidth = 2.5
        slide2.imagem.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
      
        slide2.backgroundColor = #colorLiteral(red: 0.8078431373, green: 0.9607843137, blue: 0.9960784314, alpha: 1)
        
        slide2.okButton.isHidden = true
        
        
        let slide3:slide = Bundle.main.loadNibNamed("slide", owner: self, options: nil)?.first as! slide
        slide3.descricao.text = "Em um ambiente aconchegante e silencioso, clique no botão para começar, assim, um cronômetro aparecerá e pedirá para que o ar seja inspirado vagarosamente, e após 5 segundos, para que seja expirado. Essa sessão poderá ser repetida quantas vezes quiserem. Ao final, clique para que o cronômetro desligue."
        
        
        
        slide3.descricao.adjustsFontForContentSizeCategory = true
        
        slide3.imagem.animationImages = relaxScreenImages
        slide3.imagem.animationDuration = 3.75
        slide3.imagem.startAnimating()
        
        slide3.isUserInteractionEnabled = true
        
        slide3.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.9450980392, blue: 0.9882352941, alpha: 1)
        
        slide3.imagem.layer.cornerRadius = 10
        slide3.imagem.layer.borderWidth = 2.5
        slide3.imagem.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
       
        slide3.okButton.addTarget(self, action: #selector(go(_:)), for: .touchUpInside)
        
    
        return [slide1, slide2, slide3]
        
    }
    
    
    func setupSlideScrollView(slides : [slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
            
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        
        pageControl.currentPage = Int(pageIndex)
        
    }
    
    
    @objc func go (_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabScreen") as! UITabBarController?
        vc!.selectedIndex = 3 //paisScreen
        self.present(vc!, animated: true, completion: nil)
        
    }
    
}


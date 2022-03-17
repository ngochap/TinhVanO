//
//  DetailViewController.swift
//  traning1.1
//
//  Created by NgocHap on 17/03/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescript: UITextField!
    
    
    var nameTitle: String? = ""
    var nameDescript: String? = ""
    var nameImage: String? = ""
    var listData1: [InforModel] = [InforModel]()
    let arrayTitle = ["Title", "Descript"]
    override func viewDidLoad() {
        super.viewDidLoad()

        imgAvatar.layer.borderWidth = 1
        imgAvatar.layer.masksToBounds = false
        imgAvatar.layer.borderColor = UIColor.black.cgColor
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.height/2
        imgAvatar.clipsToBounds = true
        addDescript()
        
    }
   
    func addDescript() {
        txtTitle.text = nameTitle
        txtDescript.text = nameDescript
        if let url = URL(string: nameImage ?? ""){
            imgAvatar.load(url: url)
        }
    }
    @IBAction func btnSave(_ sender: UIButton) {
        print("sss")
        let alert = UIAlertController(title: "Seccess", message: .none, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
        }))
        present(alert, animated: true, completion: nil)
    }
}

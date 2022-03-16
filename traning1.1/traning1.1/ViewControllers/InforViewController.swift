//
//  InforViewController.swift
//  traning1.1
//
//  Created by NgocHap on 16/03/2022.
//

import UIKit

class InforViewController: UIViewController {
    
    @IBOutlet weak var btnSync: UIButton!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var check: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        check = false
        collectionview.backgroundColor = .clear
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "PageOneCLVCell", bundle: nil), forCellWithReuseIdentifier: "PageOneCLVCell")
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionview.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        if check == false {
            btnSync.setTitle("Delete", for: .normal)
            check = true
        } else {
            btnSync.setTitle("Sync", for: .normal)
            check = false
        }
        
    }
    @IBAction func btnDelete(_ sender: UIButton) {
        if check == true {
            print("sss")
        }
    }
    
}
extension InforViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageOneCLVCell", for: indexPath) as? PageOneCLVCell else {
            return UICollectionViewCell()
        }
        
        
        cell.backgroundColor = .green
        return cell
    }
}
extension InforViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
//        let screenWidth = UIScreen.main.bounds.width - 10
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: screenWidth/2-20, height: (screenWidth/2)*5/4)
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
//        discoverCollectionView!.collectionViewLayout = layout






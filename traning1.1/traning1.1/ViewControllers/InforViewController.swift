//
//  InforViewController.swift
//  traning1.1
//
//  Created by NgocHap on 16/03/2022.
//

import UIKit

class InforViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var btnSync: UIButton!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var imgList: UIImageView!
    
    var listData: [InforModel] = [InforModel]()
    var listData1: [InforModel] = []
    var indexSelct: Int = -1
    var arrSelect: [Int] = []
    var checkEdit: Bool = false
    var checkDelete: Bool = false
    var checkList: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkEdit = false
        checkList = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        collectionview.backgroundColor = .clear
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "PageOneCLVCell", bundle: nil), forCellWithReuseIdentifier: "PageOneCLVCell")
        getHomeNimeManga(){ _,_ in }
        setupLongGestureRecognizerOnCollection()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getHomeNimeManga(andCompletion completion:@escaping (_ moviesResponse: [InforModel], _ error: Error?) -> ()) {
        listData.removeAll()
        APIService.shared.GetMangaAll() { (response, error) in
            if let listData = response{
                self.listData = listData
                DispatchQueue.main.async {
                    self.collectionview.reloadData()
                }
            }
            completion(self.listData, error)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionview.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        if checkEdit == false {
            btnSync.setTitle("Delete", for: .normal)
            checkEdit = true
        } else {
            btnSync.setTitle("Sync", for: .normal)
            checkEdit = false
        }
        collectionview.reloadData()
    }
    
    @IBAction func btnDeleteAndSync(_ sender: UIButton) {
        if checkEdit == true {
            let alert = UIAlertController(title: "Are you Delete?", message: .none, preferredStyle: .alert)
            let actionOK = UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                
                //                for i in 0..<self.arrSelect.count {
                //                    for j in 0..<self.listData.count {
                //                        if self.arrSelect[i] == j {
                //                            self.listData.remove(at: j)
                //                        }
                //                    }
                //                }
                var arrI = [Int]()
                for (i,e) in self.listData.enumerated(){
                    if !e.check{
                        arrI.append(i)
                    }
                }
                if arrI.count > 0{
                    let arrayR = self.listData
                        .enumerated()
                        .filter { !arrI.contains($0.offset) }
                        .map { $0.element }
                    self.listData = arrayR
                    
                }
                self.collectionview.reloadData()
                self.arrSelect = []
            })
            alert.addAction(actionOK)
            let actionCancle = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(actionCancle)
            if arrSelect != [] {
                present(alert, animated: true, completion: nil)
            }
        } else {
            print("aaa")
            listData.removeAll()
            getHomeNimeManga(){ _,_ in }
        }
    }
    
    @IBAction func btnList(_ sender: Any) {
        if checkList == false {
            imgList.image = UIImage.init(named: "option")
            checkList = true
        } else {
            imgList.image = UIImage.init(named: "list1")
            checkList = false
        }
    }
}

extension InforViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageOneCLVCell", for: indexPath) as? PageOneCLVCell else {
            return UICollectionViewCell()
        }
        if indexSelct == indexPath.row {
            let alert = UIAlertController(title: "Are you Delete?", message: .none, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
                self!.listData.remove(at: self?.indexSelct ?? 0)
                self?.indexSelct = -1
                collectionView.reloadData()
            })
            alert.addAction(okAction)
            let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancleAction)
            
            present(alert, animated: true)
        }
        
        if checkEdit == false {
            cell.checkView.isHidden = true
        } else {
            if arrSelect.contains(indexPath.row) {
                cell.imgCheck.image = UIImage(named: "ic_check")
            } else {
                cell.imgCheck.image = UIImage(named: "ic_uncheck")
            }
            cell.checkView.isHidden = false
        }
        cell.backgroundColor = .clear
        cell.lbTitle.text = listData[indexPath.row].title
        cell.lbDescrip.text = listData[indexPath.row].descript
        cell.imgAvata.image = UIImage.init(named: listData[indexPath.row].image)
        if let url = URL(string: listData[indexPath.row].image){
            cell.imgAvata.load(url: url)
        }
        return cell
    }
    private func setupLongGestureRecognizerOnCollection() {
        
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionview?.addGestureRecognizer(longPressedGesture)
        
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        
        let p = gestureRecognizer.location(in: collectionview)
        print(p)
        if let indexPath = collectionview?.indexPathForItem(at: p) {
            indexSelct = indexPath.row
            
            print("aaa: \(indexSelct)")
            collectionview.reloadData()
        }
    }
    
    
}

extension InforViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        if checkEdit == true {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageOneCLVCell", for: indexPath) as? PageOneCLVCell else {
                return
            }
            if arrSelect.contains(indexPath.row) {
                for i in 0..<arrSelect.count {
                    if arrSelect[i] == indexPath.row {
                        arrSelect.remove(at: i)
                        collectionView.reloadData()
                        return
                    }
                }
            } else {
                listData[indexPath.row].check = !listData[indexPath.row].check
                arrSelect.append(indexPath.row)
                collectionView.reloadData()
            }
            
        }
        else {
            vc.nameTitle = listData[indexPath.row].title
            vc.nameDescript = listData[indexPath.row].descript
            vc.nameImage = listData[indexPath.row].image
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
extension InforViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if checkList == false {
                self.listData
                
                return CGSize(width: collectionView.bounds.width, height: 150)
            } else {
                return CGSize(width: collectionView.bounds.width / 2.1, height: 250)
            }
        }
        if checkList == false {
            self.listData
            
            return CGSize(width: collectionView.bounds.width, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width / 2.1, height: 200)
        }
    }
}






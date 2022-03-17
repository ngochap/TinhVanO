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
    @IBOutlet weak var imgList: UIImageView!
    
    var listData: [InforModel] = [InforModel]()
    var listData1: [InforModel] = [InforModel]()
    var arrSelect: [Int] = []
    var checkEdit: Bool = false
    var checkDelete: Bool = false
    var checkList: Bool = false
    var didselect: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        checkEdit = false
        checkList = false
        collectionview.backgroundColor = .clear
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "PageOneCLVCell", bundle: nil), forCellWithReuseIdentifier: "PageOneCLVCell")
        
        getHomeNimeManga(){ _,_ in }
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
                
                for i in 0..<self.listData.count {
                    for j in self.arrSelect {
                        if i == j {
                            self.listData.remove(at: i)
                        }
                    }
                    self.collectionview.reloadData()
                    self.arrSelect = []

                }
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
        if checkList == false {
            return CGSize(width: collectionView.bounds.width, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width / 2.1, height: 200)
        }
    }
}






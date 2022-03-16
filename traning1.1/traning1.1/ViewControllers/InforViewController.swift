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
    var checkEdit: Bool = false
    var checkList: Bool = false
    
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
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        if checkEdit == true {
            print("sss")
        } else {
            print("aaa")
            //clearCache()
            getHomeNimeManga(){ _,_ in }
            
        }
    }
    
    func clearContents(_ url:URL) {

        do {

            let contents = try FileManager.default.contentsOfDirectory(atPath: url.path)

            print("before  \(contents)")

            let urls = contents.map { URL(string:"\(url.appendingPathComponent("\($0)"))")! }

            urls.forEach {  try? FileManager.default.removeItem(at: $0) }

            let con = try FileManager.default.contentsOfDirectory(atPath: url.path)

            print("after \(con)")

        }
        catch {

            print(error)

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
       
        cell.lbTitle.text = listData[indexPath.row].title
        cell.lbDescrip.text = listData[indexPath.row].descript
        cell.imgAvata.image = UIImage.init(named: listData[indexPath.row].image)
        if let url = URL(string: listData[indexPath.row].image){
            cell.imgAvata.load(url: url)
                  }
        return cell
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}




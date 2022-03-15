//
//  UserDefault.swift
//  traning1.1
//
//  Created by NgocHap on 15/03/2022.
//

import UIKit

struct User {
    let name: String
    let age: Int
}

class UserDefault: UIViewController {
    @IBOutlet weak var segment: UISegmentedControl!
    
    let userDfault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        showUserDefault()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if userDfault.integer(forKey: "segment") == 0{
            segment.selectedSegmentIndex = 0
        } else {
            segment.selectedSegmentIndex = 1
        }
    }
    func showUserDefault() {
        
        let user = User(name: "name", age: 24)
        userDfault.set("NgocHap", forKey: "name")
        userDfault.set(24, forKey: "age")
        
        print(userDfault.string(forKey: "name"))
        print(userDfault.integer(forKey: "age"))
        
        userDfault.register(defaults: [
            "enableSould": true,
            "NgocHap": false
        ])
        print(UserDefaults.standard.bool(forKey: "NgocHap"))
    }
    @IBAction func segment(_ sender: UISegmentedControl) {

        let segment = segment.selectedSegmentIndex
        userDfault.set(segment, forKey: "segment")
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "KeyChainViewController") else { return  }
        navigationController?.pushViewController(vc, animated: true)
    }
}

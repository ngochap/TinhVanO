//
//  KeyChainViewController.swift
//  traning1.1
//
//  Created by NgocHap on 15/03/2022.
//

import UIKit
import Security

class KeyChainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteItems()
    }
    func addItem() {
        let query = [
            kSecValueData: "NgocHap".data(using: .utf8),
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        print("Status: \(status)")
    }
    func addItemAndStatus() {
        let query = [
            kSecValueData: "hello_NgocHap".data(using: .utf8),
            kSecAttrAccount: "hapfx",
            kSecAttrServer: "hap.dev",
            kSecClass: kSecClassInternetPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        print("Status: \(status)")
    }
    func addItemAndReturnAtributes() {
        let query = [
            kSecValueData: "hello_ngochap".data(using: .utf8)!,
            kSecAttrAccount: "hapfx",
            kSecAttrServer: "hap.dev",
            kSecClass: kSecClassInternetPassword,
            kSecReturnAttributes: true
        ] as CFDictionary

        var ref: AnyObject?

        let status = SecItemAdd(query, &ref)
        print("Status: \(status)")
        print("Result:")
        let result = ref as! NSDictionary
        result.forEach { key, value in
            print("\(key) : \(value)")
        }
    }
    func addItemAndReturnData() {
        let query = [
            kSecValueData: "1234".data(using: .utf8),
            kSecAttrAccount: "admin",
            kSecAttrServer: "hap.dev",
            kSecClass: kSecClassInternetPassword,
            kSecReturnData: true,
            kSecReturnAttributes: true
        ] as CFDictionary
        
        var ref: AnyObject?
        let status = SecItemAdd(query, &ref)
        let result = ref as! NSDictionary
        print("openration finished with status: \(status)")
        print("username: \(result[kSecAttrAccount] ?? "")")
        let passwordData = result[kSecValueData] as! Data
        let passwordString = String(data: passwordData, encoding: .utf8)
        
        print("password: \(passwordData)")
        print("password: \(passwordString ?? "")")
    }
    func retrievingItems() {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: "hap.dev",
            kSecReturnData: true,
           // kSecMatchLimit: 20,
            kSecReturnAttributes: true,
            
        ] as NSDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        print("openr finished : \(status)")
        let array = result as! [NSDictionary]
        
        array.forEach{ dic in
            let username = dic[kSecAttrAccount] ?? ""
            let passwordData = dic[kSecValueData] as! Data
            let password = String(data: passwordData, encoding: .utf8)
            
            print("username: \(username)")
            print("password: \(password)")
            print("password: \(passwordData)")
        }
    }
    func updateItems() {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: "hap.dev",
            kSecAttrAccount: "admin"
        ]as NSDictionary
        
        let updateFilds = [
            kSecValueData: "ahihi".data(using: .utf8)
        ] as NSDictionary
        let status = SecItemUpdate(query, updateFilds)
        print("openration: \(status)")
    }
    
    func deleteItems() {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: "hapfx",
            kSecAttrServer: "hap.dev"
            
        ] as NSDictionary
        SecItemDelete(query)
    }
}

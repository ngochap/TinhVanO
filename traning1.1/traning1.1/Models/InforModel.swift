//
//  InforModel.swift
//  traning1.1
//
//  Created by NgocHap on 16/03/2022.
//

import Foundation

class InforModel: NSObject {
    var title: String = ""
    var descript: String = ""
    var image: String = ""
    
    func initLoad(_ json:  [String: Any]) -> InforModel{
        if let temp = json["title"] as? String { title = temp }
        if let temp = json["Descript"] as? String { descript = temp }
        if let temp = json["image"] as? String { image = temp }

        return self
    }
}

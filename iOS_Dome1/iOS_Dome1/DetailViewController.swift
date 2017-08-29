//
//  DetailViewController.swift
//  iOS_Dome1
//
//  Created by Aresthor on 2017/8/29.
//  Copyright © 2017年 Aresthor. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    var person:Person?
    //闭包的返回值是可选的
    //var completionCallBack:()->()?
    //闭包是可选的
    var completionCallBack:(()->())?

    override func viewDidLoad() {
        super.viewDidLoad()

        if (person != nil){
            nameText.text=person?.name
            phoneText.text=person?.phone
            titleText.text=person?.title
        }
    }


    @IBAction func savePerson(_ sender: Any) {
        person?.name=nameText.text
        person?.phone=phoneText.text
        person?.title=titleText.text
        
        completionCallBack?()
        
        _=navigationController?.popViewController(animated: true)
    }
}

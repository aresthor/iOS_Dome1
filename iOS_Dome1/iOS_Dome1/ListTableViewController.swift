//
//  ListTableViewController.swift
//  iOS_Dome1
//
//  Created by Aresthor on 2017/8/29.
//  Copyright © 2017年 Aresthor. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var personList=[Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData{(list) in
            print(list)
            self.personList+=list
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadData(completion:@escaping (_ list:[Person])->())->(){
        
        DispatchQueue.global().async {
            print("正在努力加载中...")
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM=[Person]()
            
            for i in 0..<20{
                let p=Person()
                
                p.name="ZhangSan-\(i)"
                p.phone="1860"+String(format: "%06D", arc4random_uniform(100000))
                p.title="Boss"
                
                arrayM.append(p)
            }
            
            DispatchQueue.main.async(execute: {
                completion(arrayM)
            })
        }
    }
    
    // MARK - 控制器跳转方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc=segue.destination as! DetailViewController
        
        if let indexPath=sender as? IndexPath{
            vc.person=personList[indexPath.row]
            
            vc.completionCallBack={
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    // MARK - 代理方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "list2detail", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text=personList[indexPath.row].name
        cell.detailTextLabel?.text=personList[indexPath.row].phone
        return cell
    }
  
}

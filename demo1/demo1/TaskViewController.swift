//
//  TaskViewController.swift
//  Calendar
//
//  Created by Xutw on 2020/11/9.
//

import UIKit

class TaskViewController: UIViewController {

    
    var task: String?
    var task_num: Int = 0
    
    @IBOutlet weak var textlabel: UITextView!
    var update : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textlabel.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveTask(_ sender: Any) {
        guard let text = textlabel.text,!text.isEmpty else{
            return
        }
      
        UserDefaults().set(text,forKey: "task_\(task_num+1)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }

    @objc func deleteTask(){
        
       
        guard let count = UserDefaults().value(forKey: "count")as? Int else{
            return
        }
        let newCount = count-1
        var mytask :String?
        for x in task_num..<newCount{
            mytask = UserDefaults().value(forKey: "task_\(x+2)") as? String
            UserDefaults().set(mytask,forKey: "task_\(x+1)")
        }
        UserDefaults().set(newCount,forKey: "count")
        update?()
        
        navigationController?.popViewController(animated: true)
        
      //  UserDefaults().setValue(newCount, forKey: "count")
      //  UserDefaults().setValue(nil, forKey: "task\(currentPosition)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

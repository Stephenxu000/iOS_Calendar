//
//  TodolistViewController.swift
//  Calendar
//
//  Created by Xutw on 2020/11/9.
//

import UIKit



class TodolistViewController: UIViewController {

    @IBOutlet var tableView:UITableView!
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        // Setup
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true,forKey: "setup")
            UserDefaults().set(0,forKey: "count")
        }
        // Get all current saved tasks
        updateTasks()
    }
    
    func updateTasks(){
        
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        for x in 0..<count{
            
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
                tasks.append(task)
            }
            
        }
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! TodolistEntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async{
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
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
extension TodolistViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "Change Task"
        vc.task = tasks[indexPath.row]
        vc.task_num = indexPath.item
        vc.update = {
            DispatchQueue.main.async{
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension TodolistViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}

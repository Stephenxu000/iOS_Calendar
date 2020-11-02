//
//  ViewController.swift
//  demo1
//
//  Created by Xutw on 2020/10/31.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    //MARK: 变量
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    //这个月多少天
    var numberOfDaysInThisMonth:Int{
        let dateComponents = DateComponents(year: currentYear ,
                                                   month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month,
                                                             for: date)
        return range?.count ?? 0
    }
    //这天是周几
    var whatDayIsIt:Int{
        let dateComponents = DateComponents(year: currentYear ,
                                                    month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    //需要多加几个item
    var howManyItemsShouldIAdd:Int{
        return whatDayIsIt - 1
    }
    //MARK: 控件
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var calendar: UICollectionView!
    
    //MARK：按钮动作
    @IBAction func lastmonth(_ sender: Any) {
        if currentYear<=0{
            return
        }
        currentMonth -= 1
            if currentMonth == 0{
                currentMonth = 12
                currentYear -= 1
            }
            setUp()
        
    }
    
    @IBAction func nextmonth(_ sender: Any) {
        currentMonth += 1
            if currentMonth == 13{
                currentMonth = 1
                currentYear += 1
            }
            setUp()
    }
    //MARK: 设置真实日期
    func setUp(){
        timeLabel.text = months[currentMonth - 1] + " \(currentYear)"
        calendar.reloadData()
    }
    //MARK: 表格试图
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth + howManyItemsShouldIAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
             collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                             for: indexPath)
            if let textLabel = cell.contentView.subviews[0] as? UILabel{
                if indexPath.row < howManyItemsShouldIAdd{
                    textLabel.text = ""
                }else{
                    textLabel.text =
                         "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
                }
            }
            return cell
    }

   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 40)
    }
    //横版自动排版
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
            calendar.collectionViewLayout.invalidateLayout()
            calendar.reloadData()
        
    }
    
}


//
//  ViewController.swift
//  demo1
//
//  Created by Xutw on 2020/10/31.
//

import UIKit
    //var grade = "" //全局参数回传城市选单
enum Keys : String{
    case cityname = "Changchun"
}
    struct APIKeys {
        static let apikey = "0b9867b05e7f5e8d08e757f80de9d918" // 输入在OpenWeatherMap申请的API key
    }
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ChangeName.delegate = self
        let manager = UserDefaults()
        let cityname: String? = manager.string(forKey: Keys.cityname.rawValue)
        getWeatherData(getCityName: cityname ?? "Changchun")//预设一开始的城市为长春
        // 设置当前时间
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let time = formatter.string(from: now)
            self.currentTime.text = time
        })
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
    var weatherInfo: Weather?
    var transformDescription: String = ""
    var timer: Timer?
    var cityName: String?
    var imageName: String? = "few clouds"
    //MARK: 控件
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var calendar: UICollectionView!
    
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    
    @IBOutlet weak var locationName: UILabel!
    
    @IBOutlet weak var currentTem: UILabel!
    
    @IBOutlet weak var maxTem: UILabel!
    
    @IBOutlet weak var minTem: UILabel!
    
    @IBOutlet weak var bodyTem: UILabel!
    
    @IBOutlet weak var humdity: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var ChangeName: UITextField!
    
    @IBAction func ChangeCity(_ sender: Any) {
        if ChangeName.text! == "Changchun" {
            getWeatherData(getCityName: "Changchun")
        } else {
            let manager = UserDefaults()
            manager.setValue(ChangeName.text!, forKey: Keys.cityname.rawValue)
            getWeatherData(getCityName: ChangeName.text!)
        }
    }
    
    @IBOutlet weak var currentTime: UILabel!
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

   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        ChangeName.text = textField.text
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7.25
        return CGSize(width: width, height: 50)
    }
    //横版自动排版
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
            calendar.collectionViewLayout.invalidateLayout()
            calendar.reloadData()
        
    }
    //通过json抓去open WeatherMap的天气资讯
    func getWeatherData(getCityName:String) {
        
        if let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(getCityName)&APPID=\(APIKeys.apikey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            //      当前      print("Enter URL")
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let weather = try? decoder.decode(Weather.self, from: data) {
                    self.weatherInfo = weather
                    //                    print("did get")
                    let currentTemInFan = self.weatherInfo?.main["temp"]
                    let currentTemInCel = (currentTemInFan!-273.15)
                    let maxTemInFan = self.weatherInfo?.main["temp_max"]
                    let maxTemInCel = (maxTemInFan!-273.15)
                    let minTemInFan = self.weatherInfo?.main["temp_min"]
                    let minTemInCel = (minTemInFan!-273.15)
                    DispatchQueue.main.async {
                        self.locationName.text = self.weatherInfo?.name
                        self.currentTem.text = String(format: "%.1f", currentTemInCel) + "℃"
                        self.maxTem.text = String(format: "%.1f", maxTemInCel) + "℃"
                        self.minTem.text = String(format: "%.1f", minTemInCel) + "℃"
                       // self.humidity.text = String(format: "%.1f", (self.weatherInfo?.main["humidity"])!) + "%"
                        self.windSpeed.text = String(format: "%.1f", (self.weatherInfo?.wind["speed"])!) + "m/s"
                        self.weatherDescription.text = self.weatherInfo?.weather[0].description
                        self.descriptionEnglishTransformChinese(description: self.weatherDescription.text!)
                         print(self.weatherDescription.text!)
                        
                        // 体感转换公式
                        // 体感温度 = (1.04 × 温度) + (0.2 × 水汽压) — (0.65 × 风速) — 2.7 其中温度以摄氏度为单位、风速以公尺/秒为单位，水汽压的单位为百帕，计算公式如下:
                        // 水汽压= (相对湿度 / 100) × 6.105 × exp[ (17.27 × 温度) / (237.7 + 温度) ](其中 e=2.71828)
                        
                        let waterPressure = (((self.weatherInfo?.main["humidity"])!) / 100.0) * 6.105 * (exp((17.27 * currentTemInCel) / (237.7 + currentTemInCel)))
                        let bodyTem = (1.04 * currentTemInCel) + (0.2 * waterPressure) - (0.65 * (self.weatherInfo?.wind["speed"])!) - 2.7
                        self.bodyTem.text = String(format: "%.1f", bodyTem) + "℃"
                        
                        if self.imageName != self.weatherInfo?.weather[0].description {
                            self.imageName = self.weatherInfo?.weather[0].description ?? ""
                            UIView.transition(with: self.currentWeatherIcon,
                                              duration: 0.75,
                                              options: .transitionCrossDissolve,
                                              animations: { self.currentWeatherIcon.image = UIImage(named: self.imageName ?? "") },
                                              completion: nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    // 设定英文描述转中文
    func descriptionEnglishTransformChinese (description:String) {
        switch description {
        case "broken clouds":
            transformDescription = "少云"
            //backgroundImage.image = UIImage(named: "broken clouds1")
        case "clear sky":
            transformDescription = "晴朗"
           // backgroundImage.image = UIImage(named: "clear sky1")
        case "few clouds":
            transformDescription = "晴朗少云"
           // backgroundImage.image = UIImage(named: "few clouds1")
        case "light intensity drizzle":
            transformDescription = "毛毛细雨"
            //backgroundImage.image = UIImage(named: "light intensity drizzle1")
        case "light rain":
            transformDescription = "小雨"
            //backgroundImage.image = UIImage(named: "light rain1")
        case "mist":
            transformDescription = "薄雾"
            //backgroundImage.image = UIImage(named: "mist1")
        case "moderate rain":
            transformDescription = "雨量适中"
           // backgroundImage.image = UIImage(named: "moderate rain1")
        case "overcast clouds":
            transformDescription = "乌云密布"
           // backgroundImage.image = UIImage(named: "overcast clouds1")
        case "rain":
            transformDescription = "下雨"
           // backgroundImage.image = UIImage(named: "rain1")
        case "scattered clouds":
            transformDescription = "疏云"
           // backgroundImage.image = UIImage(named: "scattered clouds1")
        case "shower rain":
            transformDescription = "阵雨"
           // backgroundImage.image = UIImage(named: "shower rain1")
        case "snow":
            transformDescription = "下雪"
           // backgroundImage.image = UIImage(named: "snow1")
        case "thunderstorm":
            transformDescription = "雷雨"
            //backgroundImage.image = UIImage(named: "thunderstorm1")
        case "heavy intensity rain":
            transformDescription = "大雨"
            //backgroundImage.image = UIImage(named: "heavy intensity rain1")
        case "fog":
            transformDescription = "多雾"
           // backgroundImage.image = UIImage(named: "fog1")
        case "light snow":
            transformDescription = "飘雪"
           // backgroundImage.image = UIImage(named: "light snow1")
        default:
            return
        }
        self.weatherDescription.text! = transformDescription
    }
}

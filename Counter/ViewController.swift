//
//  ViewController.swift
//  Counter
//
//  Created by Евгений Амплеев on 23.08.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    
    
    @IBOutlet weak private var textViewLog: UITextView!
    @IBOutlet weak private var btnReset: UIButton!
    @IBOutlet weak private var btnAddCount: UIButton!
    @IBOutlet weak private var btnSubCount: UIButton!
    
    @IBOutlet weak private var counterValue: UILabel!
    
    // Здесь необходимо брать значение из UserDefaults
    
    public var count:Int = 0
    public var log:String = "История изменений: \n"
    
    private func logEvent(event:String){
    
        var eventDescription:String = ""
        
        switch event{
        case "add":
            eventDescription = "значение изменено на +1"
        case "sub":
            eventDescription = "значение изменено на -1"
        case "reset":
            eventDescription = "значение сброшено"
        case "subZero":
            eventDescription = "попытка уменьшения значения счетчика ниже 0"
        default:
            eventDescription = "неизвестное событие"
        
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM HH:mm:ss"
        formatter.locale = Locale(identifier: "ru_RU")
        log += "\(formatter.string(from: date)): \(eventDescription)\n"
        textViewLog.text = log
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        counterValue.text = "\(count)"
        textViewLog.isEditable = false
        textViewLog.text = log
    }

    @IBAction func btnAddCountTouchUpInsideEvent() {
        count += 1
        UserDefaults.standard.set(count, forKey: "counterValue")
        counterValue.text = "\(count)"
        logEvent(event: "add")
    }
    
    @IBAction func btnSubCountTouchInsideEvent() {
        if count > 0 {
            count -= 1
            UserDefaults.standard.set(count, forKey: "counterValue")
            counterValue.text = "\(count)"
            logEvent(event: "sub")
        }else{
            logEvent(event: "subZero")
        }
    }
    @IBAction func btnResetCountTouchInsideEvent(_ sender: Any) {
        if count != 0 {
            count = 0
            UserDefaults.standard.set(count, forKey: "counterValue")
            counterValue.text = "\(count)"
            logEvent(event: "reset")
        }
    }
}

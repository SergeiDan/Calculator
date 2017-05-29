//
//  ViewController.swift
//  Calculator
//
//  Created by Сергей Черников on 15.05.17.
//  Copyright © 2017 Сергей Черников. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    // Первое число
    var x:Double = 0
    // Второе число
    var y:Double = 0
    // Флаг вывод ввиде double
    var flagPoint:Bool = false
    // Флаг обработки первого значения
    var flagFirstVariable:Bool = true
    // Степень для добавление цифр после запятой
    var positionAfterMark:Double = -1
    // Значения тэга кнопки операции
    var tagOperation:Int = 0
    // Количество цифр в поле вывода
    var countMaxNumber:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Изменения значения в поле вывода
    func displayDigital() {
        if(!flagPoint) {
            resultLabel.text = "\(Int(x))"
        }
        else {
            resultLabel.text = "\(x)"
        }
    }
    
    // Удаление последнего элемента
    @IBAction func deleteLastDigital(_ sender: UIButton) {
        if (x != 0) {
            if(!flagPoint) {
                x = Double(Int(x/10))
            }
            else {
                positionAfterMark += 1
                x = x / pow(10,positionAfterMark)
                x = Double(Int(x/10))
                positionAfterMark += 1
                x = x * pow(10,positionAfterMark)
                positionAfterMark -= 1
                if(positionAfterMark == -1) {
                    flagPoint = false
                }
            }
            displayDigital()
        }
    }
    
    
    @IBAction func getFactorial(_ sender: UIButton) {
        var factorial:Double = 1
        if(x > 0) {
            for i in 1...Int(x) {
                factorial = factorial * Double(i)
            }
        }
        x = factorial
        resultLabel.text = "\(Int(x))"
        x = 0
    }

    @IBAction func getPower(_ sender: UIButton) {
    x = pow(x,2)
    resultLabel.text = "\(x)"
    x = 0
    }
    
    @IBAction func getSqrt(_ sender: UIButton) {
	x = sqrt(x)
	resultLabel.text = "\(x)"
	x = 0
    }
    
    @IBAction func getPi(_ sender: UIButton) {
        x =  3.14159265
        resultLabel.text = "\(x)"
        x = 0
    }
    
    // Преображения в процентный вид
    @IBAction func getPercent(_ sender: UIButton) {
        if (x != 0) {
            x = x/100
            resultLabel.text = "\(x)"
            flagFirstVariable = true
            y = x
            positionAfterMark = -1
            flagPoint = false
            x = 0
        }
    }

    // Обработка нажатие на число
    @IBAction func touchDigital(_ sender: UIButton) {
        if(countMaxNumber < 9) {
            if(!flagPoint) {
                x = Double(sender.tag) + x * 10
            }
            else {
                x =  Double(sender.tag)*pow(10,positionAfterMark) + x
                positionAfterMark -= 1
            }
            displayDigital()
            countMaxNumber += 1
        }
    }
    
    // Обработка нажатие на операцию
    @IBAction func touchOperation(_ sender: UIButton) {
        if(flagFirstVariable) {
            if(sender.tag != 0) {
                tagOperation = sender.tag
                flagFirstVariable = false
                resultLabel.text = "0"
            }
            if(x != 0) {
                y = x
            }
        }
        else {
            switch (tagOperation) { 
		          // + 
		          case 1: 
              	x = y + x 
                 break 
              // - 
              case 2: 
                 x = y - x 
                 break 
              // * 
              case 3: 
                 x = y * x 
                break 
              // / 
              case 4: 
                x = y / x 
                break 
              // % 
              case 5: 
                x = y.truncatingRemainder(dividingBy: x) 
                 break 
              default: 
                break 
            }
            resultLabel.text = "\(x)"
            flagFirstVariable = true
            y = x
        }
        countMaxNumber = 0
        positionAfterMark = -1
        flagPoint = false
        x = 0
    }
    
    // Изменения знака перед числом
    @IBAction func changeMark(_ sender: UIButton) {
        x = x * -1
        displayDigital()
    }
    
    // Изменения отображения в поля вывода
    @IBAction func changeDateType(_ sender: UIButton) {
        if(!flagPoint) {
            flagPoint = true
            resultLabel.text = "\(Int(x))."
        }
    }
    
    //  Очистка поля выводы, обнуление параметров и изменения состояния флагов
    @IBAction func clear(_ sender: UIButton) {
        resultLabel.text = "0"
        x = 0
        y = 0
        countMaxNumber = 0
        positionAfterMark = -1
        flagFirstVariable = true
        flagPoint = false
    }

}


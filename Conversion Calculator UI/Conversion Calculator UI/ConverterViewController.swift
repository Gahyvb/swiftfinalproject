//
//  ConverterViewController.swift
//  Conversion Calculator UI
//
//  Created by Geoffrey Husser on 11/9/17.
//  Copyright © 2017 Geoffrey Husser. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    var initialInput = "°C"
    var initialOutput = "°F"
    var numberOnScreen: Double = 0
    var persistentNumber: String = ""
    var inputConversionType = "°F"
    var inputConversionHolder = ""
    var outputConversionType = "°C"
    var outputConversionHolder = ""
    var conversionType = 0
    var count = 0
    var negative: Bool = false
    
    struct converter {
        var label: String
        var inputUnit: String
        var outputUnit: String
        }
    var array: [converter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputDisplay.text = initialInput
        outputDisplay.text = initialOutput
        array.append(converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"))
        array.append(converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"))
        array.append(converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi"))
        array.append(converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"))
    }
    
    @IBAction func convert(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Conversion", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: array[0].label, style: UIAlertActionStyle.default, handler: { (alertAction) in
            //self.inputDisplay?.text = self.array[0].inputUnit
            //self.outputDisplay?.text = self.array[0].outputUnit
            self.inputConversionType = "°F"
            self.outputConversionType = "°C"
            self.conversionType = 0
            self.conversionTypeChecker(number: self.conversionType)
        }))
        alert.addAction(UIAlertAction(title: array[1].label, style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.inputConversionType = "mi"
            self.outputConversionType = "km"
            self.conversionType = 1
            self.conversionTypeChecker(number: self.conversionType)
        }))
        alert.addAction(UIAlertAction(title: array[2].label, style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.inputConversionType = "km"
            self.outputConversionType = "mi"
            self.conversionType = 2
            self.conversionTypeChecker(number: self.conversionType)
        }))
        alert.addAction(UIAlertAction(title: array[3].label, style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.inputConversionType = "°C"
            self.outputConversionType = "°F"
            self.conversionType = 3
            self.conversionTypeChecker(number: self.conversionType)
        }))

        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func zeroThruTen(_ sender: UIButton) {
        
        if(count > 0){
            let endIndexInput = inputDisplay.text?.index((inputDisplay.text?.endIndex)!, offsetBy: -2)
            inputDisplay.text = inputDisplay.text?.substring(to: endIndexInput!)
            
            let endIndexOutput = outputDisplay.text?.index((outputDisplay.text?.endIndex)!, offsetBy: -2)
            outputDisplay.text = outputDisplay.text?.substring(to: endIndexOutput!)
        }
        
            if(sender.tag == 11){
            
                inputDisplay.text = inputDisplay.text! + "." + inputConversionType
                persistentNumber = persistentNumber + "."
            }
            else{
                persistentNumber = persistentNumber + String(sender.tag-1)
               // print(persistentNumber)
    
                inputDisplay.text = inputDisplay.text! + String(sender.tag-1) + inputConversionType
            }
            numberOnScreen = Double(persistentNumber)!
            conversionTypeChecker(number: conversionType)
            count = 1
        
    
    }
    
    @IBAction func clear (_ sender: Any){
        self.inputDisplay.text = inputConversionType
        self.outputDisplay.text = outputConversionType
        persistentNumber = ""
        numberOnScreen = 0;
        count = 0
        
    }

    @IBAction func positiveNegative(_ sender: UIButton) {
        //numberOnScreen = numberOnScreen - numberOnScreen - numberOnScreen
        if(persistentNumber != ""){
            if(negative == false){
                let negNumber = Double(persistentNumber)! - Double(persistentNumber)!*2
                numberOnScreen = negNumber
                inputDisplay.text = String(negNumber) + inputConversionType
                conversionTypeChecker(number: conversionType)
                negative = true
            }
            else{
                numberOnScreen = Double(persistentNumber)!
                print(numberOnScreen)
                conversionTypeChecker(number: conversionType)
                inputDisplay.text = persistentNumber + inputConversionType
                negative = false
            }
        }
        else{
            
        }
        
    }
    
    
    func conversionTypeChecker(number: Int){
        if(conversionType == 0){
            calculateFtoC()
        }
        if(conversionType == 1){
            calculateMtoK()
        }
        if(conversionType == 2){
            calculateKtoM()
        }
        if(conversionType == 3){
            calculateCtoF()
        }
    }
    func calculateFtoC(){
        inputDisplay.text = String(numberOnScreen) + inputConversionType
        numberOnScreen = (numberOnScreen - 32)*5/9
        outputDisplay.text = String(numberOnScreen) + outputConversionType
    }
    
    func calculateCtoF(){
        inputDisplay.text = String(numberOnScreen) + inputConversionType
        numberOnScreen = numberOnScreen * 9 / 5 + 32
        outputDisplay.text = String(numberOnScreen) + outputConversionType
    }
    
    func calculateMtoK(){
        inputDisplay.text = String(numberOnScreen) + inputConversionType
        numberOnScreen = numberOnScreen / 0.62137
        outputDisplay.text = String(numberOnScreen) + outputConversionType
    }
    
    func calculateKtoM(){
        inputDisplay.text = String(numberOnScreen) + inputConversionType
        numberOnScreen = numberOnScreen * 0.62137
        outputDisplay.text = String(numberOnScreen) + outputConversionType
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

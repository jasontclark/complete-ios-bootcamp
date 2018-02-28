//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currentSymbol = ""
    var finalURL = ""
    var bitcoinPrice : Double = 0.0

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
       
    }
    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    // Tells the UIPicker how many colums it should have
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Tells the UIPicker how many rows it should have
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    // Fills the UIPicker with titles from the currencyArray
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        // Get the currency symbol for the currency selected
        currentSymbol = currencySymbolArray[row]
        
        // Concatenate the baseURL with the selected currency
        finalURL = baseURL + currencyArray[row]
        
        // Call the Bitcoin API to retrieve the price
        getBitcoinCurrencyData(url: finalURL)
    }

//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitcoinCurrencyData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    let bitcoinJSON : JSON = JSON(response.result.value!)

                    self.updateBitcoinData(json: bitcoinJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinData(json : JSON) {
        if let tempPrice = json["ask"].double {
            bitcoinPrice = tempPrice
        }
        
        updateLabelWithBitcoinPrice(price: bitcoinPrice)
    }
    
//
//    //MARK: - UI Updating
//    /***************************************************************/
//
    func updateLabelWithBitcoinPrice (price : Double) {
        bitcoinPriceLabel.text = currentSymbol + " \(price)"

    }

}

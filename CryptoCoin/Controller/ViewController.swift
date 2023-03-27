//
//  ViewController.swift
//  CryptoCoin
//
//  Created by Traton Gossink on 3/25/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinmanager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinmanager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
}

    //MARK: - CoinDelegateManager

    extension ViewController: CoinManagerDelegate{
        
        func didUpdatePrice(price: String, currency: String){
            DispatchQueue.main.async {
                self.coinPrice.text = price
                self.currencyLabel.text = currency
            }
        }
            func didFailWithError(error: Error) {
                print(error)
            }
        }
    
    //MARK: - UiPickerView Delegate

    extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
            func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 1
            }
            
            func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                return coinmanager.currencyArray.count
            }
            func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                return coinmanager.currencyArray[row]
            }
            func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                let selectedCurrency = coinmanager.currencyArray[row]
                coinmanager.getCoinPrice(for: selectedCurrency)
            }

}


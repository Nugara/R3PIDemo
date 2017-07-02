//
//  BasketViewController.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 02/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var tableBasket: UITableView!
    @IBOutlet weak var textFieldCurrency: UITextField!
    
    var currencyListService: CurrencyListServicing!
    var liveQuoteService: LiveQuoteServicing!
    
    var cartItems: [CartItem] = []
    var currencies : [Currency] = []
    let picker = UIPickerView()
    var pickerIndex = 0
    var exchangeRate: Double = 1.0  // USD = default
    var total: Double = 0.0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Basket"
        setupPicker()
        computeTotal()
        refreshTotalLabel()
        fetchCurrencyList()
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension BasketViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerIndex = row
    }
}

// MARK: - UITableViewDataSource
extension BasketViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItem = cartItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        cell.labelName.text = cartItem.product.name
        cell.labelPrize.text = String(format: "%.2f %@", (computeTotalPrice(cartItem: cartItem)), currentCurrencyCode())
        cell.imageViewProduct.image = UIImage(named: cartItem.product.image)
        cell.labelQuantity.text = "\(cartItem.quantity)"
        
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension BasketViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

// MARK: - utils
extension BasketViewController {
    
    public func setup() {
        BasketConfigurator().configure(viewController: self)
    }
    
    public func setupPicker() {
        
        picker.delegate = self
        picker.dataSource = self
        textFieldCurrency.inputView = picker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BasketViewController.donePicker))
        toolBar.setItems([doneButton], animated: false)
        
        textFieldCurrency.inputAccessoryView = toolBar
    }
    
    public func donePicker() {
        self.view.endEditing(false)
        let currency = currencies[pickerIndex]
        textFieldCurrency.text = currency.label
        fetchQuote(from: "USD", to: currency.code)
    }
    
    public func fetchCurrencyList() {
        
        showLoading()
        
        currencyListService.fetch(success: { [weak self] currencies in
            self?.currencies =  currencies.sorted { (object1, object2) -> Bool in
                return object1.label < object2.label
            }
            DispatchQueue.main.async {
                self?.hideLoading()
            }
        }) { [weak self] error in
            DispatchQueue.main.async {
                self?.hideLoading()
            }
            print(error)
        }
    }
    
    public func computeTotal() {
        total = 0
        for cartItem in cartItems {
            total += Double(cartItem.quantity) * cartItem.product.price
        }
        total *= exchangeRate
    }
    
    func computeTotalPrice(cartItem: CartItem) -> Double {
        return cartItem.product.price * Double(cartItem.quantity) * exchangeRate
    }
    
    func refreshTotalLabel() {
        labelTotal.text = String(format: "Tot.  %.2f %@", total, currentCurrencyCode())
    }
    
    func currentCurrencyCode() -> String {
        return currencies.count > 0 ? currencies[pickerIndex].code : "USD"
    }
    
    public func fetchQuote(from : String, to: String) {
        
        self.showLoading()
        
        liveQuoteService.fetch(from: from, to: to, success: { [weak self] quote in
            let key = quote.source + to
            self?.exchangeRate = quote.quotes[key]!
            self?.reload()
            print(quote)
        }) { [weak self] error in
            self?.hideLoading()
            print(error)
        }
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableBasket.reloadData()
            self.hideLoading()
            self.computeTotal()
            self.refreshTotalLabel()
        }
    }
}

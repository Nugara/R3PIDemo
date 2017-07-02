//
//  ProductListViewController.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var productListService: ProductListService!
    var cartItems: [CartItem] = []
    
    @IBOutlet weak var tableProductList: UITableView!
  
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
        self.title = "Products"
        fetchProductList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let basketController = segue.destination as! BasketViewController
        basketController.cartItems = cartItems.filter { $0.quantity > 0 }
    }
}

// MARK: - private
extension ProductListViewController {
    
    fileprivate func setup() {
        ProductListConfigurator().configure(viewController: self)
    }
    
    fileprivate func fetchProductList() {
        
        showLoading()
        
        productListService.fetch(success: { [weak self] products in
            self?.hideLoading()
            self?.updateCartItems(products: products)
            self?.tableProductList.reloadData()
        }) { [weak self] error in
            self?.hideLoading()
            print(error)
        }
    }
    
    fileprivate func updateCartItems(products: [Product]) {
        cartItems.removeAll()
        for product in products {
            let cartItem = CartItem(product: product, quantity: 0)
            cartItems.append(cartItem)
        }
    }
}

// MARK: - UITableViewDataSource
extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cartItem = cartItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.labelName.text = cartItem.product.name
        cell.imageViewProduct.image = UIImage(named: cartItem.product.image)
        cell.labelUnit.text = cartItem.product.unit
        cell.labelPrice.text = String(format: "%.2f USD", cartItem.product.price)  
        cell.productIndex = indexPath.row
        cell.delegate = self
        
        return cell
    }
}

// MARK: - ProductTableViewCellDelegate
extension ProductListViewController: ProductTableViewCellDelegate {
    
    func addButtonTapped(at index: Int) {
        cartItems[index].quantity += 1
        updateQuantityInCell(at: index)
    }
    
    func removeButtonTapped(at index: Int) {
        let quantity = cartItems[index].quantity
        cartItems[index].quantity = (quantity > 0) ? quantity - 1 : 0
        updateQuantityInCell(at: index)
    }
    
    fileprivate func updateQuantityInCell(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        let cell = tableProductList.cellForRow(at: indexPath) as! ProductTableViewCell
        cell.labelQuantity.text = "\(cartItems[index].quantity)"
    }
}

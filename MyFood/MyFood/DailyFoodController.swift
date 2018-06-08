//
//  DailyFoodController.swift
//  MyFood
//
//  Created by yurii zhuk on 6/7/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import GoogleAPIClientForREST
import UIKit
import GoogleSignIn

class DailyFoodController: UITableViewController {
    
    private var sheetsDataProvider: GoogleSheetsDataProvider!
    private var output: UITextView!
    var token: GTMFetcherAuthorizationProtocol!
    
    //    init(_ authentificator: GTMFetcherAuthorizationProtocol) {
    //        super.init(nibName: nil, bundle: nil)
    //        configureSheetsDataProvider(from: authentificator)
    //    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("done")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(token)
        print("called")
    }
    
    var meals: [Meal] = {
        let firstMeal = Meal(mealName: "rise", portions: 1, descriprion: "RISE", image: UIImage(named: "Page1")!)
        let secondMeal = Meal(mealName: "rise", portions: 1, descriprion: "RISE", image: UIImage(named: "Page1")!)
        let thirdMeal = Meal(mealName: "rise", portions: 1, descriprion: "RISE", image: UIImage(named: "Page1")!)
        let fourthMeal = Meal(mealName: "rise", portions: 1, descriprion: "RISE", image: UIImage(named: "Page1")!)
        return [firstMeal, secondMeal, thirdMeal]
    }()
    
    let cellIdentifier = "FoodItem"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheetsDataProvider(from: token)
        configureOutputLog()
        requestDataFromProvider()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func configureSheetsDataProvider(from token: GTMFetcherAuthorizationProtocol) {
        print(self.token)
        sheetsDataProvider = GoogleSheetsDataProvider(token)
        sheetsDataProvider.delegate = self
    }
    
    private func configureOutputLog() {
        self.output = UITextView(frame: view.bounds)
        view.addSubview(output)
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
    }
    
    private func requestDataFromProvider() {
        sheetsDataProvider.listMajors {[weak self] model in
            print("entered thus scope")
            print(model.getMenuItemsString())
            
//            self?.output.text = model.getMenuItemsString()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(meals.count)
        
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DailyFoodCell
        let meal = meals[indexPath.row]
        
        if let dequeuedcell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DailyFoodCell {
            cell = dequeuedcell
        } else {
            cell = DailyFoodCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
            
        }
        
        
        cell.setMeal(meal: meal)
        
        print(cell.mealName)
        
        cell.backgroundColor = .red
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let cellIndex = indexPath.row
        performSegue(withIdentifier: "presentPopover", sender: self)
    }
    
    
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension DailyFoodController: GoogleSheetsDataProviderDelegate {
    func didFailFetchingData(with error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
        print("here")
    }
    
}


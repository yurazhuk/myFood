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
    private let cellIdentifier = "FoodItem"
    var meals = [Meal]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("done")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheetsDataProvider(from: token)
        configureOutputLog()
        requestDataFromProvider()
        
        meals.append(Meal(mealName: "freak", portions: 1, descriprion: "RISE", image: UIImage(named: "Page1")!))
        print("this will be done first")
        
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
    
    private func requestDataFromProvider(){
        sheetsDataProvider.listMajors({[weak self] model in
//            print(self?.meals[1].mealName as Any)
            print("this will be done fastest")
            
    //            self?.output.text = model.getMenuItemsString()
            }, range: Calendar.currentDayOfWeek)
        print("this will be done second")
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

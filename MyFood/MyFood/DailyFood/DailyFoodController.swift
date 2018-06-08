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

class DailyFoodController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var sheetsDataProvider: GoogleSheetsDataProvider!
    private var output: UITextView!
    var token: GTMFetcherAuthorizationProtocol!
    private let cellIdentifier = "FoodItem"
    private var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSheetsDataProvider(from: token)
        requestDataFromProvider()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func configureSheetsDataProvider(from token: GTMFetcherAuthorizationProtocol) {
        print(self.token)
        sheetsDataProvider = GoogleSheetsDataProvider(token)
        sheetsDataProvider.delegate = self
    }
    
    private func requestDataFromProvider(){
        sheetsDataProvider.listMajors({[weak self] model in
            self?.createMenu(with: model.workerMeal)
            print(model.workerMeal)
            self?.tableView.reloadData()
            }, range: Calendar.currentDayOfWeek)
    }
    
    private func createMenu(with food: [String]) {
        food.forEach{
        meals.append(Meal(mealName: $0))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentPopover"{
            let destVC = segue.destination as? PopOverViewController
            destVC?.meal = meals[(tableView.indexPathForSelectedRow?.row)!]
            
        }
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DailyFoodController: GoogleSheetsDataProviderDelegate {
    func didFailFetchingData(with error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
        print("here")
    }
}

extension DailyFoodController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(meals.count)
        
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DailyFoodCell
        let meal = meals[indexPath.row]
        
        if let dequeuedcell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DailyFoodCell {
            cell = dequeuedcell
        } else {
            cell = DailyFoodCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        cell.setMeal(meal: meal)
        cell.backgroundColor = .red
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "presentPopover", sender: self)
    }
    
}





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
    
    init(_ authentificator: GTMFetcherAuthorizationProtocol) {
        super.init(nibName: nil, bundle: nil)
        configureSheetsDataProvider(from: authentificator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var meals: [Meal] = {
        let firstMeal = Meal(mealName: "rise", portions: 1, descriprion: "RISE")
        return [firstMeal]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutputLog()
        requestDataFromProvider()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func configureSheetsDataProvider(from token: GTMFetcherAuthorizationProtocol) {
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
        print("entered this scope")
        sheetsDataProvider.listMajors {[weak self] model in
            print("entered thus scope")
            self?.output.text = model.getMenuItemsString()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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

    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DailyFoodController: GoogleSheetsDataProviderDelegate {
    func didFailFetchingData(with error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
        print("here")
    }
    
}

//extension DailyFoodController: GoogleLoginManagerDelegate {
//    func didFailToLogin(with error: Error) {
//        showAlert(title: "Authentication Error", message: error.localizedDescription)
//    }
//
//    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol) {
//        self.output.isHidden = false
//        output.text = "Getting sheet data..."
//        sheetsDataProvider.updateServiceAuthorizer(to: authorizer)
//        requestDataFromProvider()
//        //        present(DailyFoodScreenController(), animated: true, completion: nil)
//    }
//}


//
//  SearchViewController.swift
//  RealmLoadImage
//
//  Created by GraceToa on 22/05/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var table: UITableView!
    var cityList = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        searchTF.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        cityList.removeAll()
        queryCitiesRealm()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = cityList[indexPath.row]
        cell.textLabel?.text = city.title
        cell.detailTextLabel?.text = city.subtitle
        return cell
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.cityList.removeAll()
            if (textField.text?.count)! > 0 {
                let realm = try! Realm()
                let predicate = NSPredicate(format: "title CONTAINS [c] %@", textField.text!)
                let filteredCity = realm.objects(City.self).filter(predicate)
                
                for city in filteredCity {
                    self.cityList.append(city)
                    self.table.reloadData()
                }
            }else{
               self.queryCitiesRealm()
            }
        }
        return true
    }
    
    func queryCitiesRealm() {
        let realm = try! Realm()
        let cities = realm.objects(City.self)
        for c in cities {
            self.cityList.append(c)
        }
        self.table.reloadData()
    }
}

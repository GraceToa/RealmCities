//
//  CityTableViewController.swift
//  RealmLoadImage
//
//  Created by GraceToa on 19/05/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit
import RealmSwift

class CityTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var cityList: Results<City>!
    var notificationToken: NotificationToken?
    let realm = RealmService.shared.realm

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cityList = realm.objects(City.self)
        notificationToken = realm.observe{ notification, realm in
            self.table.reloadData()
        }
    }
    
    // MARK: - UITableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityTableViewCell
        let city: City
        city = cityList[indexPath.row]
        cell.title.text = city.title
        cell.subtitle.text = city.subtitle
        let imageDef = UIImage(named: "placeholder")
        cell.picture.image = UIImage(data: city.image ?? (imageDef?.pngData())!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let city = self.cityList[indexPath.row]
        RealmService.shared.delete(city)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            if let id = self.table.indexPathForSelectedRow {
                print("this is a table")
                let cityRow = cityList[id.row]
                let destin = segue.destination as! DetailViewController
                destin.city = cityRow
            }
        }
    }

    @IBAction func deleteAllBtn(_ sender: Any) {
        RealmService.shared.deleteAll()
    }
    
}

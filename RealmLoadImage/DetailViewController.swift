//
//  DetailViewController.swift
//  RealmLoadImage
//
//  Created by GraceToa on 20/05/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var subtitleL: UILabel!
    
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let city = city {
            titleL.text = city.title
            subtitleL.text = city.subtitle
            let imageDefault = UIImage(named: "placeholder")
            image.image = UIImage(data: city.image ?? (imageDefault?.jpegData(compressionQuality: 0.20))! )
        }

    }

    // MARK: - Actions
    
    @IBAction func editBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEdit" {
            
                let destin = segue.destination as! AddEditViewController
                destin.city = city
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

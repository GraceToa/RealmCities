//
//  AddEditViewController.swift
//  RealmLoadImage
//
//  Created by GraceToa on 19/05/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit
import RealmSwift

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var subtitleTF: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    var image: UIImage?
    var city: City?
    var id = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let city = city {
            titleTF.text = city.title
            subtitleTF.text = city.subtitle
            picture.image = UIImage(data: city.image!)
            id = city.id
        }
    }
    

    // MARK: - Navigation


    @IBAction func saveCity(_ sender: UIButton) {
      
        if   id != "" {
            print("Existe CITY")
            let cityUpdate = City()
            cityUpdate.title = titleTF.text!
            cityUpdate.subtitle = subtitleTF.text!
            cityUpdate.image = image?.jpegData(compressionQuality: 0.20)
            cityUpdate.id = id
            
            RealmService.shared.update(cityUpdate)
            navigationController?.popToRootViewController(animated: true)
        }else{
            print(" NO Existe CITY")

            let cityNew = City()
            cityNew.title = titleTF.text!
            cityNew.subtitle = subtitleTF.text!
            cityNew.image = image?.jpegData(compressionQuality: 0.20)
            cityNew.id = UUID().uuidString
            
            RealmService.shared.create(cityNew)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension AddEditViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK:- UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageTake = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.picture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.picture.contentMode = .scaleAspectFill
        self.picture.clipsToBounds = true
        image = imageTake!
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Add Picture
    
    @IBAction func addPicture(sender: AnyObject) {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
            
        }
//        else {
//            let imagePicker = UIImagePickerController()
//            imagePicker.allowsEditing = true
//            imagePicker.sourceType = .camera
//            imagePicker.delegate = self
//            self.present(imagePicker, animated: true, completion: nil)
//        }
    }
    
}

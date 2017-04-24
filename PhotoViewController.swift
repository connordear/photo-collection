//
//  PhotoViewController.swift
//  PhotoCollection
//
//  Created by Connor Dear on 2017-04-21.
//  Copyright © 2017 Connor Dear. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    var imagePicker = UIImagePickerController()
    var existingPhoto : Photo? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if existingPhoto != nil {
            photoImageView.image = UIImage(data: existingPhoto!.photo! as Data)
            titleField.text = existingPhoto?.title
            addUpdateButton.setTitle("Update", for: .normal)
        }
        if existingPhoto == nil {
            deleteButton.isHidden = true
        }
    }
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(existingPhoto!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addTapped(_ sender: Any) {
        if existingPhoto != nil {
            existingPhoto?.title = titleField.text
            existingPhoto?.photo = UIImagePNGRepresentation(photoImageView.image!)! as NSData
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let photoToBeAdded = Photo(context: context)
            photoToBeAdded.title = titleField.text
            photoToBeAdded.photo = UIImagePNGRepresentation(photoImageView.image!)! as NSData
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

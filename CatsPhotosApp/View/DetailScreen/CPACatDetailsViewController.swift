//
//  CPACatDetailsViewController.swift
//  CatsPhotosApp
//
//  Created by Yulia on 12.10.2021.
//

import UIKit
import CoreData

class CPACatDetailsViewController: UIViewController {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveImageButton: UIButton!
    
    @IBOutlet weak var heightButtonsConstraint: NSLayoutConstraint!
    @IBOutlet weak var addFavoritesButton: UIButton!
    
    var images: [NSManagedObject] = []
    
    @IBAction func saveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        saveImageButton.isEnabled = false
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: CPAStrings.saveError.localized, message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: CPAStrings.saved.localized, message: CPAStrings.imageSavedInPhoto.localized, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func addFavorites(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CPAConstants.imageClass, in: managedContext)!
        let image = NSManagedObject(entity: entity, insertInto: managedContext)
        let imageData = self.imageView.image?.jpegData(compressionQuality: 1.0)
        
        image.setValue(imageData, forKey: CPAConstants.imageKey)
        
        do {
            try managedContext.save()
            images.append(image)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        addFavoritesButton.isEnabled = false
        
        let ac = UIAlertController(title: CPAStrings.saved.localized, message: CPAStrings.imageAddedToFavorites.localized, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    var details: CPACatsModel!
    var imageManaget = CPAImageManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImages()
        setTitleForButtons()
        setCornerRadiusForButtons()
    }
    
    func getImages() {
        let imageUrl = details.url
        imageManaget.getImage(urlData: imageUrl) { image in
            self.imageView.image = image!
        }
    }
    
    func setTitleForButtons() {
        saveImageButton.setTitle(CPAStrings.savePhoto.localized, for: .normal)
        addFavoritesButton.setTitle(CPAStrings.addToFavorited.localized, for: .normal)
        
        saveImageButton.titleLabel?.textAlignment = .center
        addFavoritesButton.titleLabel?.textAlignment = .center
    }
    
    func setCornerRadiusForButtons() {
        saveImageButton.layer.cornerRadius = heightButtonsConstraint.constant / 5
        addFavoritesButton.layer.cornerRadius = heightButtonsConstraint.constant / 5
    }
}

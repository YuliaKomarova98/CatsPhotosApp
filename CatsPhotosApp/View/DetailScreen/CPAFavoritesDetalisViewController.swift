//
//  CPAFavoritesDetalisViewController.swift
//  CatsPhotosApp
//
//  Created by Yulia on 13.10.2021.
//

import UIKit
import CoreData

class CPAFavoritesDetalisViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveImageButton: UIButton!
    @IBOutlet weak var deleteFavoritesButton: UIButton!
    @IBOutlet weak var heightButtonsConstraint: NSLayoutConstraint!
    
    @IBAction func saveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        saveImageButton.isEnabled = false
    }
    @IBAction func deleteFavorites(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(imageInfo)

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    var imageInfo = NSManagedObject()
    override func viewDidLoad() {
        super.viewDidLoad()

        getImage()
        setTitleForButtons()
        setCornerRadiusForButton()
    }
    
    func getImage() {
        let imageData = imageInfo.value(forKey: CPAConstants.imageKey) as? Data
        let image = UIImage(data: imageData!)
        imageView.image = image
    }
    
    func setTitleForButtons() {
        saveImageButton.setTitle(CPAStrings.savePhoto.localized, for: .normal)
        deleteFavoritesButton.setTitle(CPAStrings.removeFormFavorites.localized, for: .normal)
        saveImageButton.titleLabel?.textAlignment = .center
        deleteFavoritesButton.titleLabel?.textAlignment = .center
    }
    
    func setCornerRadiusForButton() {
        saveImageButton.layer.cornerRadius = heightButtonsConstraint.constant / 5
        deleteFavoritesButton.layer.cornerRadius = heightButtonsConstraint.constant / 5
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

}

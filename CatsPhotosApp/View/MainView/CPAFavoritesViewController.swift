//
//  CPAFavoritesViewController.swift
//  CatsPhotosApp
//
//  Created by Yulia on 13.10.2021.
//

import UIKit
import CoreData

class CPAFavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var images: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = CPAStrings.favorites.localized
        registerCells()
        if let layout = collectionView?.collectionViewLayout as? CPACustomLayout {
          layout.delegate = self
        }
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: CPAConstants.STMFavoritesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CPAConstants.STMFavoritesCollectionViewCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CPAConstants.imageClass)
        
        do {
            images = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? CPAFavoritesDetalisViewController, let indexPath = sender as? IndexPath {
            vc.imageInfo = images[indexPath.row]
        }
    }
}

extension CPAFavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: CPAConstants.toDetalisImageSegue, sender: indexPath)
    }
}

extension CPAFavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageData = images[indexPath.row].value(forKey: CPAConstants.imageKey) as? Data
        let image = UIImage(data: imageData!)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CPAConstants.STMFavoritesCollectionViewCell, for: indexPath)
        (cell as? CPAFavoritesCollectionViewCell)?.imageView.image = image
        return cell
    }
}

extension CPAFavoritesViewController: CustomLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
      return 200
  }
}

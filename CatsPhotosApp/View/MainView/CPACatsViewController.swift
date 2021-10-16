//
//  CPACatsViewController.swift
//  CatsPhotosApp
//
//  Created by Yulia on 07.10.2021.
//

import UIKit

class CPACatsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter = CPAPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        title = CPAStrings.mainScreen.localized
        registerCells()
        presenter.fetchData()
        
        if let layout = collectionView?.collectionViewLayout as? CPACustomLayout {
          layout.delegate = self
        }
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: CPAConstants.STMCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CPAConstants.STMCollectionViewCell)
        collectionView.register(UINib(nibName: CPAConstants.STMFetchCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CPAConstants.STMFetchCollectionViewCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? CPACatDetailsViewController, let indexPath = sender as? IndexPath {
            vc.details = presenter.catsList[indexPath.row]
        }
    }
}

extension CPACatsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: CPAConstants.toDetailsViewSegue, sender: indexPath)
    }
}

extension CPACatsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfrows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < presenter.numberOfrows - 1 else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CPAConstants.STMFetchCollectionViewCell, for: indexPath)
            presenter.fetchData()
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CPAConstants.STMCollectionViewCell, for: indexPath)
        (cell as? CPACollectionViewCell)?.model = presenter.cellModelForRow(indexPath.row)
        
        return cell
    }
}

extension CPACatsViewController: CPAPresenterDeledate {
    func updateUI() {
        self.collectionView.reloadData()
    }
}

extension CPACatsViewController: CustomLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
      guard let initialHeight = presenter.cellModelForRow(indexPath.row)?.height else {return 0.0}
      let initialWidth = presenter.catsList[indexPath.row].width
      let ratio: CGFloat = CGFloat(initialHeight) / CGFloat(initialWidth)
      let width: CGFloat = UIScreen.main.bounds.width / 2 - 10
      return CGFloat(width * ratio)
  }
}

//
//  MyCarsVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class MyCarsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GarageCollCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "garageCell", for: indexPath) as! GarageCollCell
//        cell.configureCell(car: "hello", index: indexPath)
        cell.delegate = self
        return cell
    }
    
    func didSelectCar(index: IndexPath) {
        print("car index")
    }
}

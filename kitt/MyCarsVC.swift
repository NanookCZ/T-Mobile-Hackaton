//
//  MyCarsVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK

class MyCarsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GarageCollCellDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var cars: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cars = Model.instance.currentCars ?? []
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60 )
        return frame
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "garageCell", for: indexPath) as! GarageCollCell
        cell.configureCell(car: cars[indexPath.row], index: indexPath)
        cell.delegate = self
        return cell
    }
    
    func didSelectCar(index: IndexPath) {
        print("car index")
    }
}

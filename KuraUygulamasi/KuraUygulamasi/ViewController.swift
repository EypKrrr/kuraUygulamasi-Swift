//
//  ViewController.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 26.09.2021.
//

import UIKit

class ViewController: UIViewController {

    let collectionView = UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout())
    
    var menuList : [MainPageMenuType] = MainPageMenuHelper.menuItems

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        self.view.addSubview(collectionView)
        
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let navCon = storyboard.instantiateViewController(withIdentifier: "MainVC") as! UINavigationController
//        self.navigatio
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as! MainPageCollectionViewCell
        cell.setFields(imageName: menuList[indexPath.row].iamgeName, titleText: menuList[indexPath.row].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedVC = menuList[indexPath.row].toVC
        self.navigationController?.pushViewController(selectedVC, animated: true)
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-20, height: (view.frame.size.width/2)-20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

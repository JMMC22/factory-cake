//
//  ViewController.swift
//  cakefactory
//
//  Created by Jose Maria Marquez on 20/11/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionCakeView: UICollectionView!

    var viewModel: MainViewModelProtocol?
    var cakes: [Cake] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        setDelegates()
        viewModel?.getCakeList()
    }

    private func setViewModel() {
        viewModel = MainViewModel(cakeService: CakeService())
    }

    private func setDelegates() {
        viewModel?.delegate = self
        collectionCakeView.delegate = self
        collectionCakeView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cakes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CakeCell", for: indexPath) as! CakeCollectionViewCell

        cell.titleCake.text = cakes[indexPath.row].title
        if let url = URL(string: cakes[indexPath.row].image!) {
            cell.imageCake.downloadImage(from: url)
        } else {
            cell.imageCake.image = UIImage(named: "splashCake")
        }
        return cell
    }
}

extension MainViewController: MainViewModelDelegate {

    func fetchData(cakes: [Cake]) {
        self.cakes = cakes
        self.collectionCakeView.reloadData()
    }

}


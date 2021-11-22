//
//  ViewController.swift
//  cakefactory
//
//  Created by Jose Maria Marquez on 20/11/21.
//

import UIKit

class MainViewController: UIViewController {

    var viewModel: MainViewModelProtocol?

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
    }
}


extension MainViewController: MainViewModelDelegate {
    
}


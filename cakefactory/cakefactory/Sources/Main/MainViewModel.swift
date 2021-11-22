//
//  MainViewModel.swift
//  cakefactory
//
//  Created by Jose Maria Marquez on 22/11/21.
//

import Foundation

class MainViewModel: MainViewModelProtocol {

    weak var delegate: MainViewModelDelegate?
    var cakeService: CakeServiceProtocol

    init(cakeService: CakeServiceProtocol) {
        self.cakeService = cakeService
    }

    func getCakeList() {
        cakeService.getCakes(completionHandler: { result in
            switch result {
            case .success(let cakes):
                print(cakes)
            case .failure(let error):
                print(error)
            }
        })
    }

}

protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? { get set }
    var cakeService: CakeServiceProtocol { get set }

    func getCakeList()
}

protocol MainViewModelDelegate: AnyObject {

}

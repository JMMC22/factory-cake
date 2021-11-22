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
                self.getCakeListDidSuccess(cakes: cakes)
            case .failure(let error):
                print(error)
            }
        })
    }

    private func getCakeListDidSuccess(cakes: [Cake]) {
        DispatchQueue.main.async {
            let sortedCakeList = self.sortListCakes(cakes: cakes)
            self.delegate?.fetchData(cakes: sortedCakeList)
        }
    }

    private func sortListCakes(cakes: [Cake]) -> [Cake] {
        var sortedList: [Cake] = []
        sortedList = cakes.uniqued()
        return sortedList.sorted(by: { $0.title! < $1.title! })
    }

}

protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? { get set }
    var cakeService: CakeServiceProtocol { get set }

    func getCakeList()
}

protocol MainViewModelDelegate: AnyObject {
    func fetchData(cakes: [Cake])
}

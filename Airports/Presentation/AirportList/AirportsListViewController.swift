//
//  AirportsListViewController.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AirportListViewController: UIViewController {

    @IBOutlet weak var selectButton: UIButton!
    
    var viewModel: AirportsListViewModel!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindNaviItem()
    }

}

// MARK: - Binding
extension AirportListViewController {
    
    private func bindNaviItem(){
        selectButton.rx.tap
            .bind(to: viewModel.input.selectCity)
            .disposed(by: disposeBag)
    }
    
}

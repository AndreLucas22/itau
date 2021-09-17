//
//  PRViewModel.swift
//  itau
//
//  Created by André Lucas on 14/09/21.
//

import Foundation
import RxSwift
import RxCocoa

final class PRViewModel {
    
    private let usecases: PRUseCases
    private let disposebag = DisposeBag()
    
    let litsPR = BehaviorRelay<PRModel?>(value: nil)
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    init(usecases: PRUseCases = PRUseCasesImpl()) {
        self.usecases = usecases
    }
    
    func getListPR(repoUser: String) {
        usecases.getListPR(criadorRep: repoUser)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] pullRequestInfo in
                self?.litsPR.accept(pullRequestInfo)
                self?.isLoading.accept(false)
            }).disposed(by: disposebag)
    }
    
    func getNumberOfRows() -> Int {
        guard let count = litsPR.value?.count else { return 0 }
        return count
    }
    
    func getCellInfo(_ row: Int) -> PRModelElement {
        guard let litsPRItems = litsPR.value else { return PRModelElement.init(title: nil, user: nil, createdAt: nil, body: "")}
        
        return litsPRItems[row]
    }
}

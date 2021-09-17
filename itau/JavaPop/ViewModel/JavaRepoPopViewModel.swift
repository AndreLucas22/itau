//
//  javaRepoPopViewModel.swift
//  itau
//
//  Created by André Lucas on 12/09/21.
//

import Foundation
import RxSwift
import RxCocoa

final class JavaRepoPopViewModel {
    
    private let usecases: JavaRepoPopUseCases
    private let disposebag = DisposeBag()
    
    let javaRepoList = BehaviorRelay<JavaPopModel?>(value: nil)
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    init(usecases: JavaRepoPopUseCases = JavaRepoPopUseCasesImpl()) {
        self.usecases = usecases
    }
    
    func getListPopReposit(_ page: Int) {
        usecases.getPopReposit(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] popRepositInfo in
                if let item = self?.javaRepoList.value?.items, item.count > 0, let popRepo = popRepositInfo.items{
                    let items = item + popRepo
                    self?.javaRepoList.accept(JavaPopModel(items: items))
                    
                } else {
                    self?.javaRepoList.accept(popRepositInfo)
                }
                self?.isLoading.accept(false)
            }).disposed(by: disposebag)
    }
    
    func getNumberOfRows() -> Int {
        guard let count = javaRepoList.value?.items?.count else { return 0 }
        return count
    }
    
    func getCellInfo(_ row: Int) -> Item {
        guard let javaRepoItem = javaRepoList.value?.items else { return Item.init(id: 0, name: "", fullName: "", owner: Owner.init(avatarURL: "", userLogin: ""), itemDescription: "", stargazersCount: 0, forks: 0)}
        
        return javaRepoItem[row]
    }
}

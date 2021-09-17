//
//  JavaRepoPopViewModelSpec.swift
//  itauTests
//
//  Created by André Lucas on 16/09/21.
//

import Quick
import Nimble
import RxSwift

@testable import itau

private final class JavaRepoPopUseCasesMock: JavaRepoPopUseCases {
    func getPopReposit(page: Int) -> Observable<JavaPopModel> {
        return Observable.just(
            JavaPopModel.init(
                items: [
                    Item.init(id: 0, name: "teste 1", fullName: "nome completo teste", owner: Owner.init(avatarURL: "https://teste.com.br", userLogin: "user teste"), itemDescription: "descrição de um item teste", stargazersCount: 4, forks: 4),
                    Item.init(id: 1, name: "teste 2", fullName: "nome completo teste1", owner: Owner.init(avatarURL: "https://teste.com.br", userLogin: "user teste1"), itemDescription: "descrição de um item teste", stargazersCount: 4, forks: 4),
                    Item.init(id: 2, name: "teste 3", fullName: "nome completo teste2", owner: Owner.init(avatarURL: "https://teste.com.br", userLogin: "user teste2"), itemDescription: "descrição de um item teste", stargazersCount: 4, forks: 4),
                    Item.init(id: 3, name: "teste 4", fullName: "nome completo teste3", owner: Owner.init(avatarURL: "https://teste.com.br", userLogin: "user teste3"), itemDescription: "descrição de um item teste", stargazersCount: 4, forks: 4)
                ]
            )
        )
    }
    
    
}

private class JavaRepoPopViewModelSpec: QuickSpec {
    override func spec() {
        let model = JavaRepoPopViewModel(usecases: JavaRepoPopUseCasesMock())
        context("Match values"){
            it("initialization") {
                expect(model).notTo(beNil())
            }
        }
        
        context("checking number of rows will be returned") {
            beforeEach {
                model.getListPopReposit(0)
            }
            it("should return 4"){
                expect(model.getNumberOfRows()).to(equal(4))
            }
        }
        
        context("check if the correct value for cell is coming") {
            beforeEach {
                model.getListPopReposit(0)
                
            }
            it("validate information"){
                let item1 = model.getCellInfo(0)
                let item2 = Item.init(id: 0, name: "teste 1", fullName: "nome completo teste", owner: Owner.init(avatarURL: "https://teste.com.br", userLogin: "user teste"), itemDescription: "descrição de um item teste", stargazersCount: 4, forks: 4)
                expect(item1==item2).to(beTrue())
            }
        }
        
    }
}

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.forks == rhs.forks && lhs.fullName == rhs.fullName &&
            lhs.id == rhs.id && lhs.itemDescription == rhs.itemDescription && lhs.name == rhs.name && lhs.owner?.avatarURL == rhs.owner?.avatarURL
            && lhs.owner?.userLogin == rhs.owner?.userLogin && lhs.stargazersCount == rhs.stargazersCount
    }
}

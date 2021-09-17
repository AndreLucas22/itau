//
//  PRViewModelSpec.swift
//  itauTests
//
//  Created by André Lucas on 16/09/21.
//

import Quick
import Nimble
import RxSwift

@testable import itau

private class PRUseCasesMock: PRUseCases {
    func getListPR(criadorRep: String) -> Observable<PRModel> {
        return Observable.just(
            PRModel.init(arrayLiteral:
                            PRModelElement.init(title: "titulo teste", user: User.init(login: "teste", id: 0, avatarURL: "http//teste.com"), createdAt: "2021-06-04T09:16:26Z", body: ""),
                         PRModelElement.init(title: "titulo teste", user: User.init(login: "teste", id: 0, avatarURL: "http//teste.com"), createdAt: "2021-06-04T09:16:26Z", body: ""),
                         PRModelElement.init(title: "titulo teste", user: User.init(login: "teste", id: 0, avatarURL: "http//teste.com"), createdAt: "2021-06-04T09:16:26Z", body: ""))
        )
    }
    
}

private class PRViewModelSpec: QuickSpec {
    override func spec() {
        let model = PRViewModel(usecases: PRUseCasesMock())
        context("Match values"){
            it("initialization") {
                expect(model).notTo(beNil())
            }
        }
        
        context("checking number of rows will be returned") {
            beforeEach {
                model.getListPR(repoUser: "")
            }
            it("should return 3"){
                expect(model.getNumberOfRows()).to(equal(3))
            }
        }
        
        context("check if the correct value for cell is coming") {
            beforeEach {
                model.getListPR(repoUser: "")

            }
            it("validate information"){
                let item1 = model.getCellInfo(0)
                let item2 = PRModelElement.init(title: "titulo teste", user: User.init(login: "teste", id: 0, avatarURL: "http//teste.com"), createdAt: "2021-06-04T09:16:26Z", body: "")
                expect(item1==item2).to(beTrue())
            }
        }
        
    }
}

extension PRModelElement: Equatable {
    public static func == (lhs: PRModelElement, rhs: PRModelElement) -> Bool {
        return lhs.body == rhs.body && lhs.createdAt == rhs.createdAt && lhs.title == rhs.title && lhs.user?.avatarURL == rhs.user?.avatarURL && lhs.user?.id == rhs.user?.id && lhs.user?.login == rhs.user?.login
    }
}


//
//  JavaRepoPopUseCases.swift
//  itau
//
//  Created by André Lucas on 13/09/21.
//

import Foundation
import RxSwift
import Alamofire

protocol JavaRepoPopUseCases {
    func getPopReposit(page: Int) -> Observable<JavaPopModel>
}

final class JavaRepoPopUseCasesImpl: JavaRepoPopUseCases {
    func getPopReposit(page: Int) -> Observable<JavaPopModel> {
        if let apiUrl = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") {
            let url = "\(apiUrl)search/repositories?q=language:Java&sort=stars&page=\(page)"
            return Observable<JavaPopModel>.create{ (observable) -> Disposable in
                let requestReference = AF.request(url).validate(statusCode: 200..<300)
                    .responseDecodable(of:JavaPopModel.self) { response in
                        switch response.result {
                        case .failure(let error):
                            observable.onError(error)
                        case .success(let data):
                            observable.onNext(data)
                            observable.onCompleted()
                        }
                    }
                return Disposables.create(with: {
                    requestReference.cancel()
                })
            }
        } else { return Observable.empty() }
        
    }
}

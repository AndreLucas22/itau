//
//  PRUseCases.swift
//  itau
//
//  Created by André Lucas on 14/09/21.
//

import Foundation
import RxSwift
import Alamofire

protocol PRUseCases {
    func getListPR(criadorRep: String) -> Observable<PRModel>
}

final class PRUseCasesImpl: PRUseCases {
    func getListPR(criadorRep: String) -> Observable<PRModel> {
        if let apiUrl = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") {
            let url = "\(apiUrl)repos/\(criadorRep)/pulls"
            return Observable<PRModel>.create{ (observable) -> Disposable in
                let requestReference = AF.request(url).validate(statusCode: 200..<300)
                    .responseDecodable(of:PRModel.self) { response in
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

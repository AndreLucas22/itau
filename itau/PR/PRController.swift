//
//  PRController.swift
//  itau
//
//  Created by André Lucas on 14/09/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class PRController: UIViewController {
    private var viewModel: PRViewModel
    private var repoInfo: Item
    private lazy var customView = PRView(delegate: self, dataSource: self)
    private let disposeBag = DisposeBag()
    
    // MARK: - initializers
    init(viewModel: PRViewModel, repoInfo: Item) {
        self.viewModel = viewModel
        self.repoInfo = repoInfo
        super.init(nibName: nil, bundle: nil)
        self.title = repoInfo.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setNavigationBar()
        viewModel.getListPR(repoUser: repoInfo.fullName ?? "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
    }
    
}

// MARK: - private methods
extension PRController {
    
    private func bindView() {
        viewModel.litsPR
            .observe(on: MainScheduler.instance)
            .subscribe({[weak self] _ in
                self?.customView.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

extension PRController: UITableViewDelegate {}

extension PRController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = viewModel.getNumberOfRows()
        if numberOfRows == 0 {
            tableView.setLoad()
        } else {
            tableView.restore()
        }
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PRViewCell.self)) as? PRViewCell else {
            return UITableViewCell()
        }
        cell.setupInfos(viewModel.getCellInfo(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

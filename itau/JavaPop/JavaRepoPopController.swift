//
//  javaRepoPopCoordinator.swift
//  itau
//
//  Created by André Lucas on 12/09/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class JavaRepoPopController: UIViewController {
    
    private var viewModel: JavaRepoPopViewModel
    private lazy var customView = JavaRepoPopView(delegate: self, dataSource: self)
    private let disposeBag = DisposeBag()
    private var page = 0
    
    // MARK: - initializers
    init(viewModel: JavaRepoPopViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Github JavaPop"
    }
    
}

// MARK: - private methods
extension JavaRepoPopController {
    private func bindView() {
        viewModel.javaRepoList
            .observe(on: MainScheduler.instance)
            .subscribe({[weak self] _ in
                self?.customView.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    private func loadMoreData() {
        if !self.viewModel.isLoading.value {
            self.viewModel.isLoading.accept(true)
            page += 1
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                // Download more data here
                DispatchQueue.main.async {
                    
                    self.viewModel.getListPopReposit(self.page)
                }
            }
        }
    }
}

extension JavaRepoPopController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoInfo = self.viewModel.getCellInfo(indexPath.row)
        let viewModel = PRViewModel()
        let controller = PRController(viewModel: viewModel, repoInfo: repoInfo)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !viewModel.isLoading.value {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
}

extension JavaRepoPopController: UITableViewDataSource {
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JavaRepoPopListCell.self)) as? JavaRepoPopListCell else {
            return UITableViewCell()
        }
        cell.accessibilityTraits = UIAccessibilityTraits.button
        cell.accessibilityLabel = "pode ser clicado"
        cell.setupInfos(viewModel.getCellInfo(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}

//
//  ExampleTableViewController.swift
//  RHViewStateKit
//
//  Created by Bagus andinata on 25/07/21.
//  Copyright (c) 2021 All rights reserved.
//  Template by BagusAnDinata
//

import UIKit
import RHViewStateKit

class ExampleTableViewController: UIViewController {
    //MARK: - PROPERTY
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        return view
    }()
    
    lazy var reloadButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 32, height: 32)))
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(reloadTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    
    private struct TableContent {
        var state: TableViewState
        var title: String
        var description: String
    }
    
    private var content: [TableContent] {
        return [TableContent(state: .EmptyData, title: "Empty data", description: "example empty data"),
                TableContent(state: .InternalError, title: "Internal Error", description: "example internal error"),
                TableContent(state: .Maintenance, title: "Maintenance", description: "example maintenance"),
                TableContent(state: .NoInternet, title: "No Internet", description: "example no internet"),]
    }
    
    //MARK: - UIVIEWCONTROLLER LIFECYLE
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        var configLoading = RHLoadingConfiguration()
        configLoading.backgroundColor = .black.withAlphaComponent(0.5)
        configLoading.color = .red
        tableView.viewState.delegate = self
        tableView.viewState.loading = configLoading
        
        configureConstraints()
        configureNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - METHOD
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func configureNavBar() {
        navigationItem.title = "RHViewStateKit"
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = reloadButton
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
    
    //MARK: - ACTION
    @objc
    private func reloadTapped() {
        tableView.viewState.hide()
    }
}

extension ExampleTableViewController: RHViewStateDelegate {
    func viewState(_ viewState: RHViewState, didTapButton button: UIButton) {
        viewState.hide()
    }
}

extension ExampleTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = content[indexPath.row].title
        cell.descriptionLabel.text = content[indexPath.row].description
        cell.arrowRight.isHidden = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.viewState.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) { [weak self] in
            guard let `self` = self else { return }
            self.tableView.viewState.hideLoader()
            self.tableView.viewState.show(self.content[indexPath.row].state)
        }
    }
}

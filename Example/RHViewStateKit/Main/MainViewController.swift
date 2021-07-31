//
//  MainViewController.swift
//  RHViewStateKit
//
//  Created by Bagus andinata on 17/07/21.
//  Copyright (c) 2021 All rights reserved.
//  Template by BagusAnDinata
//

import UIKit
import RHViewStateKit

class MainViewController: UIViewController {
    //MARK: - PROPERTY
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        return view
    }()
    
    private struct MainContent {
        var title: String
        var description: String
    }
    
    private var content: [MainContent] {
        return [MainContent(title: "Using container UIViewController", description: "RHViewState implement in UIViewController"),
                MainContent(title: "Using container UITableView", description: "RHViewState implement in UITableView"),
                MainContent(title: "Using container UICollectionView", description: "RHViewState implement in UICollectionView")]
    }
    
    //MARK: - UIVIEWCONTROLLER LIFECYLE
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
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
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
    
    //MARK: - ACTION
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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
        switch indexPath.row {
        case 0:
            let vc = ExampleViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ExampleTableViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = ExampleViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

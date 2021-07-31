//
//  ExampleViewController.swift
//  RHViewStateKit
//
//  Created by Bagus andinata on 21/07/21.
//  Copyright (c) 2021 All rights reserved.
//  Template by BagusAnDinata
//

import UIKit
import RHViewStateKit

fileprivate enum ViewControllerState: RHViewCollectionState {
    case noInternet
}

class ExampleViewController: UIViewController {
    //MARK: - PROPERTY
    private let content: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum molestie, dolor eu ultricies tristique, lacus turpis vestibulum odio, at egestas nibh leo a est. Aenean bibendum ligula eros, sit amet ultricies nisi volutpat in. Aenean eget feugiat est, ac rhoncus justo. Integer vulputate lorem felis, vitae gravida mi consequat eu. Nunc volutpat id est eu pulvinar. Ut neque nisi, efficitur eu odio molestie, gravida posuere quam. Morbi consectetur id urna et dapibus. Nunc finibus vulputate lorem ut interdum. Cras convallis massa eros, ut pulvinar nisi consectetur eu. Aenean maximus laoreet velit, in auctor felis hendrerit vel. Mauris dapibus ultricies pellentesque. Suspendisse dignissim elit et tortor aliquet, cursus fermentum sapien volutpat. Duis metus ex, accumsan et sapien at, vulputate scelerisque nunc. Nam non enim ac lacus luctus convallis dignissim eu mauris. Curabitur eu tellus commodo libero sollicitudin placerat eget sit amet turpis. Sed dolor est, lacinia sed gravida ut, efficitur sit amet velit./nSed non gravida sapien. In feugiat rhoncus nisi, eu rutrum leo feugiat sed. Vestibulum semper maximus elementum. Nunc molestie libero urna, in aliquam felis eleifend et. Donec ante tortor, tempus non euismod quis, imperdiet ut urna. Integer mauris quam, consectetur ut sem vel, iaculis dapibus mauris. Donec orci neque, aliquet ac aliquet sit amet, elementum nec ipsum. Donec pretium eu nibh a tincidunt. Morbi blandit neque tortor, at egestas sem accumsan sed. Phasellus bibendum egestas euismod. Cras congue, velit sit amet lobortis dignissim, magna erat ullamcorper sapien, quis ullamcorper nunc urna sed tellus./nMaecenas in justo ac lectus tempus consectetur quis eget nulla. Sed ac tellus faucibus, ullamcorper ex vitae, blandit augue. Cras lectus risus, vestibulum at sapien a, egestas malesuada lorem. Nullam luctus nulla vitae commodo sollicitudin. Donec semper tortor in dapibus vestibulum. Pellentesque porttitor lacus massa, eu ultricies orci vestibulum nec. Ut est justo, aliquet nec blandit quis, luctus ullamcorper tellus. Etiam at congue odio. Nunc ac feugiat leo. Suspendisse potenti. Maecenas porta tortor justo, id ultrices quam elementum a. Donec condimentum venenatis dui. Cras in leo augue. Nam et arcu congue, finibus orci viverra, tempus tortor."
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
    
    //MARK: - UIVIEWCONTROLLER LIFECYLE
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(content)
        
        configureConstraints()
        configureNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingSize = CGSize(width: 50, height: 50)
        var configLoading = RHLoadingConfiguration()
        configLoading.view = EActivityIndicatorView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: loadingSize), type: .ballPulseSync, color: UIColor.init(hex: "##ffd600"))
        configLoading.size = loadingSize
        view.viewState.loading = configLoading
        view.viewState.delegate = self
        view.viewState.dataSource = self
    }
    
    //MARK: - METHOD
    private func configureConstraints() {
        content.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
    
    private func configureNavBar() {
        navigationItem.title = "UIViewController"
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
        view.viewState.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) { [weak self] in
            self?.view.viewState.hideLoader()
            self?.view.viewState.show(ViewControllerState.noInternet)
        }
    }
}

extension ExampleViewController: RHViewStateDelegate {
    func viewState(_ viewState: RHViewState, didTapButton button: UIButton) {
        view.viewState.hide()
    }
}

extension ExampleViewController: RHViewStateDataSource {
    func rhPositionConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHPositionConfiguration {
        return RHPositionConfiguration(view: .center, text: .center, image: .top)
    }
    
    func rhButtonConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHButtonConfiguration {
        var config = RHButtonConfiguration()
        config.color = .clear
        config.attributes = [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.red]
        return config
    }
    
    func imageForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> UIImage? {
        switch state as! ViewControllerState {
        case .noInternet:
            return UIImage(named: "ic-no-internet")
        }
    }
    
    func titleForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String? {
        switch state as! ViewControllerState {
        case .noInternet:
            return "No Internet Connection"
        }
    }
    
    func descriptionForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String? {
        switch state as! ViewControllerState {
        case .noInternet:
            return "Try turning on your WIFI or Mobile Data for using the app"
        }
    }
    
    func titleButtonForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String? {
        switch state as! ViewControllerState {
        case .noInternet: return "Retry"
        }
    }
}

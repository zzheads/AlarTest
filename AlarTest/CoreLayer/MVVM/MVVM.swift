//
//  BaseViewController.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

protocol ViewModel {
    var show: ((String?, String?) -> Void)? { get set }
    var showController: ((UIViewController) -> Void)? { get set }
    var present: ((UIViewController, Bool, (() -> Void)?) -> Void)? { get set }
    
    func initialSetup()
    func viewDidLoad()
    func didBindUIWithViewModel()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

protocol ViewController: UIViewController {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get }
}

class BaseViewModel: NSObject, ViewModel {
    var show: ((String?, String?) -> Void)?
    var showController: ((UIViewController) -> Void)?
    var present: ((UIViewController, Bool, (() -> Void)?) -> Void)?
    
    func initialSetup() {}
    func viewDidLoad() {}
    func didBindUIWithViewModel() {}
    
    func viewWillAppear(_ animated: Bool) {}
    func viewDidAppear(_ animated: Bool) {}
    func viewWillDisappear(_ animated: Bool) {}
    func viewDidDisappear(_ animated: Bool) {}
}

class BaseViewController<ViewModelType: ViewModel>: UIViewController, ViewController {
    var viewModel: ViewModelType
    
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        viewModel.initialSetup()
    }
    
    func setupUI() {
        
    }

    func bindUIWithViewModel() {
        viewModel.show = {
            [weak self] title, message in
            
            self?.show(title: title, message: message)
        }
        
        viewModel.showController = {
            [weak self] controller in
            
            guard let navigationController = self?.navigationController else {
                self?.show(controller, sender: self)
                return
            }
            navigationController.pushViewController(controller, animated: true)
        }
        
        viewModel.present = {
            [weak self] controller, animated, completion in
            
            self?.present(controller, animated: animated, completion: completion)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupUI()
        bindUIWithViewModel()
        viewModel.didBindUIWithViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewDidDisappear(animated)
    }
}

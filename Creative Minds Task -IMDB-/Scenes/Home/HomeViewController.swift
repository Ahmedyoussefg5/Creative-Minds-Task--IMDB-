//
//  ViewController.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

protocol HomeViewProtocol: BaseViewProtocol {
    func dataTaskSuccess()
    func indsertRow(at index: Int)
    func deleteRow(at index: Int)
}

class HomeViewController: UITableViewController, HomeViewProtocol {
    
    private var presenter: HomePresenterProtocol!
    
    // Prevent the creation of the ViewController outside of the "create" method"
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 15, weight: .bold)]
        title = "Creative Minds Task -IMDB-"
        
        createProfileNavItem()
        
        tableView.register(HomeMoviesCell.self, forCellReuseIdentifier: "HomeMoviesCell")
        presenter.getData()
    }
    
    fileprivate func createProfileNavItem() {
        // Should Be Button To Navigate User to His Profile
        let profileImageView = UIImageView(image: #imageLiteral(resourceName: "placeHolder")).withSize(.allSides(side: 40))
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    func indsertRow(at index: Int) {
        tableView.insertRows(at: [.init(row: 0, section: index)], with: .top)
    }
    
    func deleteRow(at index: Int) {
        tableView.deleteRows(at: [.init(row: 0, section: index)], with: .top)
    }
    
    func dataTaskSuccess() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HomeTableHeaderView(state: presenter.getmovieType(at: section))
        view.arrowAction = presenter.handelArrowAction
        view.seeAllAction = handelSeeAllAction
        return view
    }
    
    private func handelSeeAllAction(_ type: MovieType) {
        navigationController?.pushViewController(AllMoviesViewController.create(selectedType: type), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMoviesCell", for: indexPath) as! HomeMoviesCell
        cell.data = presenter.getData(for: presenter.getmovieType(at: indexPath.section).type)
        cell.delegate = self
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.getmovieType(at: indexPath.section).isExpanded ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getmovieType(at: section).isExpanded ? 1 : 0
    }
}

extension HomeViewController: MovieSelectProtocol {
    func select(at id: Int) {
        // GO TO MOVIE DETAILS VC with id
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension HomeViewController {
    // Create class and its dependcies
    class func create() -> HomeViewController {
        let network = Network()
        let authRepository = HomeRepository(network: network)
        let view = HomeViewController()
        let presenter = HomePresenter(view: view, authRepository: authRepository)
        view.presenter = presenter
        return view
    }
}

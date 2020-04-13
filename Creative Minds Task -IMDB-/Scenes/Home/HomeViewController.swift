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
}

class HomeViewController: UITableViewController, HomeViewProtocol {
    
    func dataTaskSuccess() {
        tableView.reloadData()
    }
    
    private var presenter: HomePresenterProtocol!
    
    private lazy var movieTypes: [MovieRowsState] = [
        .init(type: .topRated),
        .init(type: .popular),
        .init(type: .comingSoon),
        .init(type: .nowPlaying)
    ]
    
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
        
        // Should Be Button To Navigate User to His Profile
        let profileImageView = UIImageView(image: #imageLiteral(resourceName: "placeHolder")).withSize(.allSides(side: 40))
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
        tableView.register(HomeMoviesCell.self, forCellReuseIdentifier: "HomeMoviesCell")
        presenter.getData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HomeTableHeaderView(state: movieTypes[section])
        view.arrowAction = handelArrowAction
        view.seeAllAction = handelSeeAllAction
        return view
    }
    
    private func handelArrowAction(_ type: MovieType) {
        if let data = movieTypes.first(where: { $0.type == type }) {
            if data.isExpanded {
                data.isExpanded.toggle()
                tableView.deleteRows(at: [.init(row: 0, section: type.sectionNumber)], with: .top)
            } else {
                data.isExpanded.toggle()
                tableView.insertRows(at: [.init(row: 0, section: type.sectionNumber)], with: .top)
            }
        }
    }
    
    private func handelSeeAllAction(_ type: MovieType) {
        navigationController?.pushViewController(AllMoviesViewController.create(selectedType: type), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMoviesCell", for: indexPath) as! HomeMoviesCell
        cell.data = presenter.getData(for: movieTypes[indexPath.section].type)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return movieTypes[indexPath.section].isExpanded ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTypes[section].isExpanded ? 1 : 0
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

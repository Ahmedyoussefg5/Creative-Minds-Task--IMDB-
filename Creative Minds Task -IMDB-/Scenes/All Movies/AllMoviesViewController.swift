//
//  AllMoviesViewController.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

protocol AllMoviesViewProtocol: BaseViewProtocol {
    func dataTaskDone()
}

class AllMoviesViewController: UITableViewController, AllMoviesViewProtocol {
    
    var indexForExpandedCell: Int?
    
    func dataTaskDone() {
        tableView.reloadData()
    }
    
    private var topTypesCollectionView = HCollectionView()
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var presenter: AllMoviesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.getDataForSelectedType()
    }
    
    fileprivate func setup() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        topTypesCollectionView.register(MoviesTypesSliderCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesTypesSliderCollectionViewCell")
        topTypesCollectionView.delegate = self
        topTypesCollectionView.dataSource = self
        topTypesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func getTextHeight(at index: Int) -> CGFloat {
        let font: UIFont = .systemFont(ofSize: 13, weight: .medium)
        let text = presenter.getMovie(at: index)?.overview ?? ""
        return text.height(withConstrainedWidth: tableView.frame.width * 0.8, font: font)
    }
    
    // MARK: - Table view data source + Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(topTypesCollectionView)
        topTypesCollectionView.fillSuperview(padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let indexForExpandedCell = indexForExpandedCell {
            if indexPath.row == indexForExpandedCell {
                return getTextHeight(at: indexPath.row) + 190
            }
        }
        return 170
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        if let data = presenter.getMovie(at: indexPath.row) {
            cell.config(data)
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = presenter.getMoviesCount()
        return count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexForExpandedCell == indexPath.row {
            indexForExpandedCell = nil
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            indexForExpandedCell = indexPath.row
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Collection view data source + Delegate

extension AllMoviesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getTypesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesTypesSliderCollectionViewCell", for: indexPath) as! MoviesTypesSliderCollectionViewCell
        cell.config(presenter.getDataFor(index: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 130, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectType(at: indexPath.item)
        collectionView.reloadData()
        presenter.getDataForSelectedType()
    }
}

// MARK: - Create

extension AllMoviesViewController {
    // Create class and its dependcies
    class func create(selectedType: MovieType) -> AllMoviesViewController {
        let network = Network()
        let authRepository = HomeRepository(network: network)
        let view = AllMoviesViewController()
        let presenter = AllMoviesPresenter(view: view, authRepository: authRepository, selectedType: selectedType)
        view.presenter = presenter
        return view
    }
}

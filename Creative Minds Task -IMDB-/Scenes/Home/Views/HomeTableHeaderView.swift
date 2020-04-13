//
//  File.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

class HomeTableHeaderView: UIView {
    
    private let headerLable = UILabel()
    private let arrowButton = UIButton(type: .system)
    private let seeAllButton = UIButton(type: .system)
    
    private var state: MovieRowsState
    
    var seeAllAction: ((_ type: MovieType) -> ())?
    var arrowAction: ((_ type: MovieType) -> ())?
    
    fileprivate func setTargets() {
        arrowButton.addTarget {[weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.35) {
                self.arrowButton.rotate(angle: 180)
            }
            self.arrowAction?(self.state.type)
        }
        
        seeAllButton.addTarget {[weak self] in
            guard let self = self else { return }
            self.seeAllAction?(self.state.type)
        }
    }
    
    fileprivate func addViews() {
        let stack = HStack([headerLable, seeAllButton.withWidth(100), arrowButton.withWidth(35)], spacing: 10, alignment: .fill, distribution: .fill)
        
        addSubview(stack)
        stack.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    fileprivate func configView() {
        backgroundColor = .white
        seeAllButton.setTitle("Show All".localize, for: .normal)
        headerLable.text = state.type.title
        arrowButton.setImage(#imageLiteral(resourceName: "up-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        
        if state.isExpanded {
            arrowButton.rotate(angle: 180)
        }
    }
    
    fileprivate func setupHeaderView() {
        configView()
        addViews()
        setTargets()
    }
    
    init(state: MovieRowsState) {
        self.state = state
        super.init(frame: .zero)
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

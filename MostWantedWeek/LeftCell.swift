//
//  LeftCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class LeftCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var scoreObjs: [Score] = {
        var deltaGamma = Score(logoName: "DG", teamName: "Delta Gamma", scoreNum: "1029391")
        var kappaGamma = Score(logoName: "KKG", teamName: "Kappa Kappa Gamma", scoreNum: "2040")
        var phiMu = Score(logoName: "PM", teamName: "Phi Mu", scoreNum: "20194")
        var triDelta = Score(logoName: "TD", teamName: "Tri Delta", scoreNum: "45912")
        var kdChi = Score(logoName: "KDC", teamName: "Kappa Delta Chi", scoreNum: "504")
        
        return [deltaGamma, kappaGamma, phiMu, triDelta, kdChi]
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .brown
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ScoreCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scoreObjs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScoreCell
        cell.score = scoreObjs[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

//
//  HeroDetailViewController.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import UIKit
import Combine

enum HeroTransformationSection {
    case transformations
}

final class HeroDetailViewController: UIViewController {
    private let viewModel: HeroDetailViewModel
    var sucriptors = Set<AnyCancellable>()
    
    
    // MARK: - Outlets
    @IBOutlet private weak var heroImage: UIImageView!
    
    @IBOutlet private weak var nameHeroLabel: UILabel!
    @IBOutlet private weak var heroDescriptionTextView: UITextView!
    
    @IBOutlet private weak var heroTransformationCollectionView: UICollectionView!
    
    @IBOutlet private weak var emptyTransformationLabel: UILabel!
    // MARK: - DataSource
    
    typealias DataSource = UICollectionViewDiffableDataSource<HeroTransformationSection,HeroTransformation>
    typealias CellRegistration = UICollectionView.CellRegistration<TransformationCell, HeroTransformation>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HeroTransformationSection, HeroTransformation>
    
    // MARK: - Data
    
    private var dataSource: DataSource?
    private var transformations:[HeroTransformation] = []
    
    // MARK: - Initializer
    
    init(viewModel: HeroDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: "HeroDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
     configViewModel()
        configureCollectionView()
    
    }
    private func configViewModel() {
        viewModel.$hero
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] optionalHero in
                guard let hero = optionalHero else {
                    return
                }
                if let photo = hero.photo, let url = URL(string: photo) {
                    self?.heroImage.loadImageRemote(url: url)
                }
                self?.nameHeroLabel.text = hero.name
                self?.heroDescriptionTextView.text = hero.description
                
            })
            .store(in: &sucriptors)
        
        
        viewModel.$transformation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transformation in
                self?.applySnapshot()
    
                if let transformations = self?.viewModel.transformation, transformations.isEmpty {
                            self?.emptyTransformationLabel.isHidden = false
                        } else {
                            self?.emptyTransformationLabel.isHidden = true
                        }
                
            }
            .store(in: &sucriptors)
        
        Task {
                await viewModel.loadDataTransformation()
            }
       
    }
    
    // MARK: - Configuración del CollectionView
    func configureCollectionView(){
        heroTransformationCollectionView.delegate = self
        // configuramos los margenes de la rejilla?
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        heroTransformationCollectionView.collectionViewLayout = layout

        
        
        let nib = UINib(nibName: TransformationCell.identifier, bundle: nil)
        let cellRegistration = CellRegistration(cellNib: nib) { cell, _, transformation in
            cell.configure(whith: transformation)
        }
        dataSource = DataSource(collectionView: heroTransformationCollectionView, cellProvider: { collectionView, indexPath, transformation in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: transformation)
        })
        
        
    }
    
    // MARK: - Function for snapshot
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.transformations])
        snapshot.appendItems(viewModel.transformation ?? [])
        dataSource?.applySnapshotUsingReloadData(snapshot)
       
    }
}



// MARK: - CollectionViewLayout
extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: collectionView.bounds.size.width, height: 80.0)
        return CGSize(width: 200, height: 80.0)
    }
    
    

    
    
}

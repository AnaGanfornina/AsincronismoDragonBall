//
//  HeroListViewController.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import UIKit
import Combine

enum HeroesSeccions {
    case heroes
}

final class HeroListViewController: UIViewController {
    private var appState: AppState?
    private var viewModel = HeroListViewModel()
    var sucriptors = Set<AnyCancellable>()
    
    // MARK: - Initializer
    
    init(appState: AppState, viewModel: HeroListViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    // MARK: - DataSource
    
    typealias DataSource = UICollectionViewDiffableDataSource<HeroesSeccions, Hero>
    typealias CellRegistration = UICollectionView.CellRegistration< HeroCollectionCell, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HeroesSeccions, Hero>
    
    // MARK: - Data
    
    private var dataSource: DataSource?
    private var heroes: [Hero] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind()
        configViewModel()
        configureCollectionView()
        //viewModel.loadData()
    }
    
    // MARK: - Actions
    
    // MARK: - Binding
    
    private func configViewModel() {
        viewModel.$heros
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &sucriptors)
    }
    
    // MARK: - Configuración del CollectionView
    
    private func configureCollectionView(){
        collectionView.delegate = self
        
        // configuramos los margenes de la rejilla
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 16
        }
        
        // Usamos un CellRegistration para crear las celdas  una ventaja que tiene es que si usamos el objeto como
        // identificador ya nos viene en el handler y no necesitamos acceder a él por su indexPath
        let nib = UINib(nibName: HeroCollectionCell.identifier, bundle: nil)
        let cellRegistration = CellRegistration(cellNib: nib) { cell, _, hero in
            
            cell.configure(with: hero)
        }
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, hero in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: hero)
            
        })
    }
    
    // MARK: - Function for snapshot
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.heroes])
        snapshot.appendItems(viewModel.heros)
        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
}
  
    // MARK: - CollectionViewLayout
    
    extension HeroListViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            
            let columNumber: CGFloat = 2
            
            
            let width = (collectionView.frame.width - 32) / columNumber
            return CGSize(width: width, height: 125)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            guard let heroSelected = dataSource?.itemIdentifier(for: indexPath) else { return }
            
            // Nos vamos al detalle del heroe
            
            navigationController?.show(HeroDetailBuilder(hero: heroSelected).build(), sender: self)
            
            
        }
    }
    

    

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

final class HeroListViewController: UITableViewController {
    private var viewModel = HeroListViewModel()
    var sucriptors = Set<AnyCancellable>()
    private var appState: AppState?
    
    init(appState: AppState, viewModel: HeroListViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("heros-title", comment: "")
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
  //      tableView.refreshControl = UIRefreshControl()
 //       tableView.refreshControl?.addTarget(self, action: #selector(cellPullToRefresh), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cerrar",
            style: .plain,
            target: self,
            action: #selector(HeroListViewController.closeSession)
        )
        configViewModel()
    }
    
    private func configViewModel() {
        self.viewModel.$heros
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &sucriptors)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.heros.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.identifier, for: indexPath) as! HeroCell
        
        let hero = self.viewModel.heros[indexPath.row]
        cell.configure(with: hero)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    @objc func closeSession(_ : UIBarButtonItem) {
        self.appState?.closeSessionUser()
    }

}

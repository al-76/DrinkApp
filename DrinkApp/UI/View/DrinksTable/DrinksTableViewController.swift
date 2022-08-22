//
//  DrinksTableViewController.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import UIKit
import Combine

final class DrinksTableViewController: UITableViewController {
    // TODO: with a DI tool we could avoid such long constructors
    private let viewModel = DrinksViewModel(repository: DefaultDrinksRepository(network: DefaultNetwork()))
    
    private var dataSource: TableViewDataSource<Drink>?
    private var cancellable: AnyCancellable?
    private let imageCache = URLCache(memoryCapacity: 1024 * 1024 * 10, diskCapacity: 1024 * 1024 * 50)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setBinding()
    }
    
    private func setTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
        
    private func setBinding() {
        cancellable = viewModel
            .$state
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                case .loading:
                    self.refreshControl?.beginRefreshing()
                    break

                case .success(let drinks):
                    self.setDataSource(drinks)
                    self.refreshControl?.endRefreshing()

                case .failure(let error):
                    self.presentAlert(error: error)
                    self.refreshControl?.endRefreshing()
                }
            }

        viewModel.fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDrinkDetails",
              let destination = segue.destination as? DrinkDetailsHostingController,
              let indexPath = tableView.indexPathForSelectedRow,
              let dataSource = self.dataSource else { return }
        
        let drink = dataSource.data[indexPath.row]
        destination.rootView.drinkId = drink.id
    }

    private func setDataSource(_ drinks: [Drink]) {
        dataSource = TableViewDataSource(data: drinks) { [weak self] tableView, indexPath, drink in
            let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
            
            guard let self = self,
                  let drinkCell = cell as? DrinksTableViewCell else { return cell }
            
            drinkCell.drinkLabel.text = drink.name
            if let url = URL(string: drink.imageUrl) {
                drinkCell.drinkIcon.load(from: url, cache: self.imageCache)
            }
            
            return drinkCell
        }
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    
    @IBAction func pullToRefresh(_ sender: Any) {
        viewModel.fetchData()
    }
}

// MARK: - Data source

private final class TableViewDataSource<T>: NSObject, UITableViewDataSource {
    typealias Build = (UITableView, IndexPath, T) -> UITableViewCell
    
    let build: Build
    let data: [T]
    
    init(data: [T], build: @escaping Build) {
        self.data = data
        self.build = build
        
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        build(tableView, indexPath, data[indexPath.row])
    }
}

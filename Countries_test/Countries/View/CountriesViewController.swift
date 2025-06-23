//
//  CountriesViewController.swift
//  Countries
//
//  Created by Yenat Feyyisa on 4/1/25.
//

import UIKit
import Combine
class CountriesViewController: UIViewController {
    // MARK: - UIComponents
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search countries..."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.backgroundColor = .systemBackground
        tableView.register(CountriesTableViewCell.self,forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let viewModel = CountriesViewModel()
    private var cancelable = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        setTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }
    
}
// MARK: - UITableView Datasource
extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?
        CountriesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.filteredCountries[indexPath.row])
        return cell
    }
}
// MARK: - UISearchBarDelegate
extension CountriesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel
            .searchCountries(searchText: searchBar.text ?? "")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel
            .searchCountries(searchText: "")
    }
}
// MARK: - helper functions
extension CountriesViewController {
    private func setUPUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Countries"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    // MARK: - bind view model to view
    private func bindViewModel() {
        if viewModel.filteredCountries.isEmpty {
            viewModel.$errorMessage
                .receive(on: DispatchQueue.main)
                .sink {[weak self] _ in
                    self?.errorMessagePopUp(title: "Error", message: self?.viewModel.errorMessage ?? "Something went wrong.")
                    self?.refreshControl.endRefreshing()
                }
                .store(in: &cancelable)
        }
        viewModel.$filteredCountries
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.reloadData()
                self?.setupAccessibility()
            }
            .store(in: &cancelable)
    }
    
    func setupAccessibility() {
        if viewModel.filteredCountries.isEmpty {
            UIAccessibility.post(notification: .announcement, argument: "No countries found matching")
        }  else  {
            UIAccessibility.post(notification: .announcement, argument: "found \(viewModel.filteredCountries.count) countries ")
        }
    }
}
    // MARK: set up table view constraints
extension CountriesViewController {
    func setTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0
                    ),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
            ]
        )
    }
}


extension CountriesViewController {
    func errorMessagePopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK button tapped")
        }
        let refreshAction = UIAlertAction(title: "Refresh", style: .default) { [weak self] _ in
            self?.viewModel.fetchCountries()
        }
        alertController.addAction(okAction)
        alertController.addAction(refreshAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func didPullToRefresh() {
        viewModel.fetchCountries()
        
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            self.refreshControl.endRefreshing()
//        }
    }

    
}

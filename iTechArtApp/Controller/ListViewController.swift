//
//  ViewController.swift
//  iTechArtApp
//
//  Created by Tsimafei Zykau on 11/23/20.
//

import UIKit

class ListViewController: UIViewController {

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    private var data = [Event]()
    private var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContoller()
    }
}

// MARK: Configure TableViewDelegate
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableViewCell
        cell.authorLabel.text = data[indexPath.row].authorName
        cell.dateLabel.text = data[indexPath.row].stringDate
        cell.avatarView.image = data[indexPath.row].avatarImage
        if data[indexPath.row].avatarImage == nil {
            let imageUrl = URL(string: data[indexPath.row].avatarUrl)!
            networkService.fetchImage(url: imageUrl) { (image) in
                if let image = image {
                    self.data[indexPath.row].avatarImage = image
                    DispatchQueue.main.async {
                        cell.avatarView.image = self.data[indexPath.row].avatarImage
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.detailData = self.data[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: Configure ScrollViewDelegate
extension ListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        let tableViewContentSizeBeforeRefresh = scrollView.contentSize.height-scrollView.frame.height-200
        
        if scrollPosition > 0, scrollPosition > tableViewContentSizeBeforeRefresh {
            guard !networkService.isPaginating else { return }
            networkService.fetchEvents(paginating: true) { (data, error) in
                if let data = data {
                    self.data.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else if let error = error {
                    self.networkService.isPaginating = true
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ListViewController {
    
    // MARK: Configure viewController
    func configureViewContoller() {
        self.view.backgroundColor = .white
        configureNavigationController()
        configureTableView()
        configureRefreshControl()
        configureConstraints()
        refresh()
    }
    
    // MARK: Configure tableView
    func configureTableView() {
        self.tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "eventCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Configure navigationController
    func configureNavigationController() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        let titleLogoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        titleLogoView.contentMode = .scaleAspectFit
        titleLogoView.image = UIImage(named: "gitHubLogo")
        self.navigationItem.titleView = titleLogoView
    }
    
    // MARK: Configure refreshControl
    func configureRefreshControl() {
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    // MARK: Configure constraints
    func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    // MARK: Selector for Refreshing Data
    @objc func refresh() {
        self.networkService.pageNumber = 0
        self.networkService.isPaginating = false
        networkService.fetchEvents { (data, error) in
            if let data = data {
                self.data = data
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.createAlertController(error: error)
                }
            }
        }
    }
    
    // MARK: Create AlertController for error
    func createAlertController(error: Error) {
        let alert = UIAlertController(title: "Error has appeared.", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


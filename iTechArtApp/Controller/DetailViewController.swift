//
//  DetailViewController.swift
//  iTechArtApp
//
//  Created by Tsimafei Zykau on 11/24/20.
//

import UIKit

class DetailViewController: UIViewController {

    var detailData: Event!
    
    private let avatarView = UIImageView(frame: .zero)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
}

// MARK: Configure TableViewDelegate
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Author Name"
        case 1:
            return "Repository Name"
        case 2:
            return "Date"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "detailCell")
            }
            return cell
        }()
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = detailData.authorName
        case 1:
            cell.textLabel?.text = detailData.repositoryName
        case 2:
            cell.textLabel?.text = detailData.stringDate
        default:
            cell.textLabel?.text = nil
        }
        
        return cell
    }
    
}

extension DetailViewController {
    
    // MARK: Configure viewController
    func configureViewController() {
        self.view.backgroundColor = .white
        self.title = detailData.authorName
        configureAvatarView()
        configureTableView()
        configureConstraints()
    }
    
    // MARK: Configure avatarView
    func configureAvatarView() {
        avatarView.contentMode = .scaleAspectFit
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.image = detailData.avatarImage
        view.addSubview(avatarView)
    }
    
    // MARK: Configure tableView
    func configureTableView() {
        self.tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        view.addSubview(tableView)
    }
    
    // MARK: Configure constraints
    func configureConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: view.frame.width/2),
            
            tableView.topAnchor.constraint(equalTo: avatarView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

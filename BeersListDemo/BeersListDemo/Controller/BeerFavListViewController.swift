//
//  BeerFavListViewController.swift
//  BeersListDemo
//
//  Created by dqh on 10/8/23.
//

import UIKit

class BeerFavListViewController: UIViewController {
    
    var dataArr: [BeerModel]? {
        didSet {
            if let arr = dataArr {
                self.favArr = arr
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorite List"
        self.view.backgroundColor = .white
        
        setupTableView()
        self.view.addSubview(self.tableView)
    }

    // fav array
    private lazy var favArr: Array<BeerModel> = {
        var tempArr = Array<BeerModel>()
        return tempArr
    }()
    
    /// setup tableView
    private func setupTableView() {
        // register
        self.tableView.register(BeerViewCell.self, forCellReuseIdentifier: ReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private let ReuseIdentifier = "ReuseIdentifier"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.frame = kTableViewFrame
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColorFromRGB(rgbValue: 0xA9A9A9)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        tableView.tableFooterView = UIView()
        return tableView
    }()
}

extension BeerFavListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cache cell
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier) as! BeerViewCell
        // content
        let beer = self.favArr[indexPath.row]
        cell.beer = beer
        if beer.target_fg == -1 {
            cell.favButton.setBackgroundImage(UIImage.init(named: "like"), for: .normal)
        }else {
            cell.favButton.setBackgroundImage(UIImage.init(named: "unlike"), for: .normal)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    // MARK: height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let beer = self.favArr[indexPath.row]
        return BeerViewCell.height(beer: beer)
    }
    
    // MARK: did Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = BeerDetailsViewController()
        detailVC.beer = self.favArr[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

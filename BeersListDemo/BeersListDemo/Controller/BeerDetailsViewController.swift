//
//  BeerDetailsViewController.swift
//  BeersListDemo
//
//  Created by dqh on 10/8/23.
//

import UIKit

class BeerDetailsViewController: UIViewController {
    
    var beer: BeerModel? {
        didSet {
            if let nameStr = beer?.name {
                self.navigationItem.title = nameStr
            }else {
                self.navigationItem.title = "Beer Detail"
            }
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
        self.view.addSubview(self.tableView)
    }
    
    // setup tableView
    private func setupTableView() {
        // register
        self.tableView.register(BeerDetailTopCell.self, forCellReuseIdentifier: ReuseIdBeerDetailTopCell)
        self.tableView.register(BeerDetailDataCell.self, forCellReuseIdentifier: ReuseIdBeerDetailDataCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    private let ReuseIdBeerDetailTopCell = "BeerDetailTopCell"
    private let ReuseIdBeerDetailDataCell = "BeerDetailDataCell"
    
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

extension BeerDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // cache cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdBeerDetailTopCell) as! BeerDetailTopCell
            // content
            cell.urlStr = beer?.image_url
            return cell
        }else {
            // cache cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdBeerDetailDataCell) as! BeerDetailDataCell
            // content
            cell.beer = beer
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return BeerDetailTopCell.height()
        }else {
            if let model = beer {
                return BeerDetailDataCell.height(beer: model)
            }else {
                return .zero
            }
        }
    }

}

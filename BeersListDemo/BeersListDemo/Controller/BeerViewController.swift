//
//  BeerViewController.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import UIKit

class BeerViewController: UIViewController, BeerViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(noNetnotificationAction), name: NSNotification.Name(rawValue: kReNetNotification), object: nil)
        
        setupUI()
    }
    
    private func setupUI() {
        self.navigationItem.title = "Beers List"
        var rightImg = UIImage(named: "like")
        rightImg = rightImg!.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: rightImg, style: .plain, target: self, action: #selector(ClickRightItem))
        self.navigationItem.rightBarButtonItem = item
        
        setupTableView()
        self.view.addSubview(self.tableView)
        self.tableView.mj_header = RefreshHeader(refreshingTarget: self, refreshingAction: #selector(HeaderRefresh))
        //self.tableView.mj_footer = RefreshFooter(refreshingTarget: self, refreshingAction: #selector(FooterRefresh))
        // beginRefreshing
        self.tableView.mj_header?.beginRefreshing()
    }
    
    /// load data
    private func loadNewStatus() {
        HttpsTool.loadData(target: API.all, model: [BeerModel].self) { model in
            DispatchQueue.main.async {
                if let beerArr = model {
                    self.beerArr = beerArr
                    self.handleFavToData()
                    
                    self.tableView.reloadData()
                    
                    if let data = try? JSONEncoder().encode(self.beerArr) {
                        UserDefaults.standard.set(data, forKey: kBeerAll)
                    }
                    
                } else {
                    Alert.show(type: .info, text: "beerModel is nil")
                }
                print("success")
                self.tableView.mj_header?.endRefreshing()
            }
            
        } failure: { code, msg in
            DispatchQueue.main.async {
                print("failure")
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func handleFavToData() {
        if let data = UserDefaults.standard.data(forKey: kBeerFav) {
            do {
                self.favArr = try JSONDecoder().decode([Int].self, from: data)
            } catch {
                print("Decoder failure")
            }
        }
        for i in 0..<self.beerArr.count {
            for j in 0..<self.favArr.count {
                let num = self.favArr[j]
                if self.beerArr[i].id == num {
                    self.beerArr[i].target_fg = -1;
                }
            }
        }
    }
    
    // MARK: - ***** Refresh
    @objc func HeaderRefresh() {
        print(" - HeaderRefresh ")
        loadNewStatus()
    }
    
    @objc func ClickRightItem() {
        print("ClickRightItem")
        let favListVC = BeerFavListViewController()
        favListVC.dataArr = handleFav()
        self.navigationController?.pushViewController(favListVC, animated: true)
    }
    
    private func handleFav() -> [BeerModel] {
        var tempArr = Array<BeerModel>()
        for i in 0..<self.beerArr.count {
            if self.beerArr[i].target_fg == -1 {
                tempArr.append(self.beerArr[i])
            }
        }
        return tempArr
    }
    
    @objc func noNetnotificationAction(noti: NSNotification) {
        let sta = noti.object as! JhNetworkStatus
        if sta == .notReachable {
            if let data = UserDefaults.standard.data(forKey: kBeerAll) {
                do {
                    self.beerArr = try JSONDecoder().decode([BeerModel].self, from: data)
                    self.handleFavToData()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decoder failure")
                }
            }
        }
    }

    // data array
    private lazy var beerArr: Array<BeerModel> = {
        var tempArr = Array<BeerModel>()
        return tempArr
    }()
    
    // fav array
    private lazy var favArr: Array<Int> = {
        var tempArr = Array<Int>()
        return tempArr
    }()
    
    // setup tableView
    private func setupTableView() {
        // register
        self.tableView.register(BeerViewCell.self, forCellReuseIdentifier: ReuseIdBeerViewCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private let ReuseIdBeerViewCell = "BeerViewCell"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.frame = kTableViewFrame
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColorFromRGB(rgbValue: 0xA9A9A9)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    func didFavLikeInCell(cell: BeerViewCell, withBeer beer: BeerModel?) {
        self.favArr.append((beer?.id)!)
        for i in 0..<self.beerArr.count {
            if self.beerArr[i].id == beer?.id {
                self.beerArr[i].target_fg = -1;
            }
        }
        
        self.tableView.reloadData()
        if let data = try? JSONEncoder().encode(self.favArr) {
            UserDefaults.standard.set(data, forKey: kBeerFav)
        }
    }
    
    func didFavUnlikeInCell(cell: BeerViewCell, withBeer beer: BeerModel?) {
        var tempArr = self.favArr
        for i in 0..<self.favArr.count {
            if self.favArr[i] == beer?.id {
                tempArr.remove(at: i)
            }
        }
        self.favArr = tempArr
        
        for i in 0..<self.beerArr.count {
            if self.beerArr[i].id == beer?.id {
                self.beerArr[i].target_fg = 100;
            }
        }

        self.tableView.reloadData()
        if let data = try? JSONEncoder().encode(self.favArr) {
            UserDefaults.standard.set(data, forKey: kBeerFav)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension BeerViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cache cell
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdBeerViewCell) as! BeerViewCell
        cell.delegate = self
        // content
        let beer = self.beerArr[indexPath.row]
        cell.beer = beer
        //
        if beer.target_fg == -1 {
            cell.favButton.setBackgroundImage(UIImage.init(named: "like"), for: .normal)
        }else {
            cell.favButton.setBackgroundImage(UIImage.init(named: "unlike"), for: .normal)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let beer = self.beerArr[indexPath.row]
        return BeerViewCell.height(beer: beer)
    }
    
    // MARK: did Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) 
        
        let detailVC = BeerDetailsViewController()
        detailVC.beer = self.beerArr[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

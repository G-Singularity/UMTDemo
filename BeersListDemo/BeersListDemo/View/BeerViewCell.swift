//
//  BeerViewCell.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import UIKit
import SnapKit
import Kingfisher
import Foundation

typealias SelectCallBack = (_ model: BeerModel) -> ()

protocol BeerViewCellDelegate: NSObjectProtocol {
    // delegate action
    //func didFavButtonInCell(cell: BeerViewCell, withBeer beer: inout BeerModel?)
    
    func didFavLikeInCell(cell: BeerViewCell, withBeer beer: BeerModel?)
    func didFavUnlikeInCell(cell: BeerViewCell, withBeer beer: BeerModel?)
}

class BeerViewCell: UITableViewCell {
    
    // delegate
    weak var delegate: BeerViewCellDelegate?
    
    var selectClousure : SelectCallBack?
    
    // data
    var beer: BeerModel? {
        didSet {
            if let urlStr = beer?.image_url {
                let url = URL(string: urlStr)
                imgView.kf.indicatorType = .activity
                imgView.kf.setImage(with: url, placeholder: UIImage.init(named: "default"))
            }else {
                imgView.image = UIImage.init(named: "default")
            }
            
            if let nameStr = beer?.name {
                nameLbl.text = nameStr
            }else {
                nameLbl.text = "name"
            }
            
            if let desc = beer?.description {
                descLbl.text = desc
            }else {
                descLbl.text = "description"
            }
            favButton.setBackgroundImage(UIImage.init(named: "unlike"), for: .normal)
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // add subviews
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(descLbl)
        self.contentView.addSubview(favButton)
        self.contentView.addSubview(actionButton)
        self.contentView.addSubview(lineView)
        
        // layout subviews
        imgView.snp.makeConstraints { make in
            make.leading.top.equalTo(self.contentView).offset(10)
            make.size.equalTo(CGSize(width: 60, height: 180))
        }
        
        nameLbl.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(10)
            make.trailing.equalTo(self.contentView).offset(10)
            make.top.equalTo(imgView)
        }
        
        descLbl.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(nameLbl.snp.bottom).offset(10)
        }
        
        favButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentView)
            make.trailing.equalTo(self.contentView)
            make.height.width.equalTo(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.height.equalTo(5)
        }
    }
    
    // MARK: - click action
    @objc private func favBtnClick(sender: UIButton) {
        //delegate?.didFavButtonInCell(cell: self, withBeer: &beer)
        
        if beer?.target_fg != -1 {
            delegate?.didFavLikeInCell(cell: self, withBeer: beer)
        }else {
            delegate?.didFavUnlikeInCell(cell: self, withBeer: beer)
        }
    }
    
    class func height(beer: BeerModel) -> CGFloat {
        var nameH: CGFloat = 0
        let cellMargin: CGFloat = 10
        if let name = beer.name {
            let size = (name as NSString).boundingRect(with: CGSize(width: kScreenWidth  - 60 - (cellMargin*3), height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font:UIFont.boldSystemFont(ofSize: 15)], context: nil)
            nameH = size.height
        }
        var descH: CGFloat = 0
        if let description = beer.description {
            let size = (description as NSString).boundingRect(with: CGSize(width: kScreenWidth - 60 - (cellMargin*3), height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font:UIFont.systemFont(ofSize: 14)], context: nil)
            descH = size.height
        }
        let total = (cellMargin + nameH + cellMargin + descH + cellMargin + 5)
        let minH = (cellMargin + 180 + cellMargin + 5)
        let result: CGFloat = (total > minH) ? total: minH
        return result
    }
    
    // MARK: - lazy subviews
    // picture imageView
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    // name label
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // description label
    private lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // favorite button
    lazy var favButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: "unlike"), for: .normal)
//        btn.setBackgroundImage(UIImage.init(named: "like"), for: .selected)
//        btn.addTarget(self, action: #selector(favBtnClick), for: .touchUpInside)
        return btn
    }()
    
    // action button
    lazy var actionButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(favBtnClick), for: .touchUpInside)
        return btn
    }()
    
    // separator
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

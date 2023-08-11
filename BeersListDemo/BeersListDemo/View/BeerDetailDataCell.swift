//
//  BeerDetailDataCell.swift
//  BeersListDemo
//
//  Created by dqh on 10/8/23.
//

import UIKit

class BeerDetailDataCell: UITableViewCell {
    
    // data
    var beer: BeerModel? {
        didSet {
            if let nameStr = beer?.name {
                nameLbl.text = "Name: " + nameStr
            }else {
                nameLbl.text = "name"
            }
            
            if let desc = beer?.description {
                descLbl.text = "Description: " + desc
            }else {
                descLbl.text = "description"
            }
            
            if let tagline = beer?.tagline {
                taglineLbl.text = "Tagline: " + tagline
            }else {
                taglineLbl.text = "tagline"
            }
            
            if let attenuation_level = beer?.attenuation_level {
                levelLbl.text = "Attenuation_level: \(attenuation_level)"
            }else {
                levelLbl.text = "attenuation_level"
            }
            
            if let abv = beer?.abv {
                abvLbl.text = "Abv: \(abv)"
            }else {
                abvLbl.text = "abv"
            }
            
            if let ph = beer?.ph {
                phLbl.text = "Ph: \(ph)"
            }else {
                phLbl.text = "ph"
            }
            
            if let contributed_by = beer?.contributed_by {
                contributedLbl.text = "Contributed_by: " + contributed_by
            }else {
                contributedLbl.text = "contributed_by"
            }
            
            if let brewers_tips = beer?.brewers_tips {
                tipsLbl.text = "Brewers_tips: " + brewers_tips
            }else {
                tipsLbl.text = "brewers_tips"
            }
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
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(descLbl)
        self.contentView.addSubview(favButton)
        
        self.contentView.addSubview(taglineLbl)
        self.contentView.addSubview(levelLbl)
        self.contentView.addSubview(abvLbl)
        self.contentView.addSubview(phLbl)
        self.contentView.addSubview(contributedLbl)
        self.contentView.addSubview(tipsLbl)
        
        // layout subviews
        nameLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(20)
        }
        
        favButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
        }
        
        taglineLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(nameLbl.snp.bottom).offset(10)
        }
        
        descLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(taglineLbl.snp.bottom).offset(10)
        }
        
        levelLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(descLbl.snp.bottom).offset(10)
        }
        
        abvLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(levelLbl.snp.bottom).offset(10)
        }
        
        phLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(abvLbl.snp.bottom).offset(10)
        }
        
        contributedLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(phLbl.snp.bottom).offset(10)
        }
        
        tipsLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.equalTo(contributedLbl.snp.bottom).offset(10)
        }
        
    }
    
    class func height(beer: BeerModel) -> CGFloat {
        //这里实际应该跟BeerViewCell的height计算一样，根据内容来得出，不过当前cell内容过多（略）
        return 600
    }
    
    // MARK: - lazy subviews
    // name label
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
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
    private lazy var favButton: UIButton = {
        let btn = UIButton(type: .custom)
        //btn.setBackgroundImage(UIImage.init(named: "unlike"), for: .normal)
        //btn.setBackgroundImage(UIImage.init(named: "like"), for: .selected)
        //btn.addTarget(self, action: #selector(favBtnClick), for: .touchUpInside)
        return btn
    }()
    
    // tagline label
    private lazy var taglineLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // attenuation_level label
    private lazy var levelLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // abv label
    private lazy var abvLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // ph label
    private lazy var phLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // contributed_by label
    private lazy var contributedLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // brewers_tips label
    private lazy var tipsLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
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

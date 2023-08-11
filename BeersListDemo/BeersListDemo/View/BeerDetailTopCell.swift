//
//  BeerDetailViewCell.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import UIKit

class BeerDetailTopCell: UITableViewCell {
    
    var urlStr: String? {
        didSet {
            if let url = urlStr {
                let url = URL(string: url)
                imgView.kf.indicatorType = .activity
                imgView.kf.setImage(with: url, placeholder: UIImage.init(named: "default"))
            }else {
                imgView.image = UIImage.init(named: "default")
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
        self.contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(180)
        }
    }
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    class func height() -> CGFloat {
        return 200
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

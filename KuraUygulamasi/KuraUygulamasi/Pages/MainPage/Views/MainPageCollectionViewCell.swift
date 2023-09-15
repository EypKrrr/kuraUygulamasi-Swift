//
//  MainPageCollectionViewCell.swift
//  Second
//
//  Created by Eyup KORURER on 21.09.2021.
//

import UIKit

final class MainPageCollectionViewCell: UICollectionViewCell {
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: (contentView.bounds.width/4), y: 10, width: (contentView.bounds.width/2), height: (contentView.bounds.height/2))
        
        titleLabel.frame = CGRect(x: 0, y: (contentView.bounds.height/4)*3, width: contentView.bounds.width, height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setFields(imageName:String, titleText:String) {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
    }
}

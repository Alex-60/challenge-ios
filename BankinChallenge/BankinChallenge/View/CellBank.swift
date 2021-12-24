//
//  CellBank.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import UIKit

class CellBank: UITableViewCell {
    
    let uiImageLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let uiLabelnameOfTheBank: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        contentView.addSubview(uiImageLogo)
        contentView.addSubview(uiLabelnameOfTheBank)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            uiImageLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            uiImageLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            uiImageLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            uiImageLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            uiImageLogo.widthAnchor.constraint(equalToConstant: 80),
            uiImageLogo.heightAnchor.constraint(equalToConstant: 80),
            
            uiLabelnameOfTheBank.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            uiLabelnameOfTheBank.leadingAnchor.constraint(equalTo: uiImageLogo.trailingAnchor, constant: 20),
            uiLabelnameOfTheBank.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }

}

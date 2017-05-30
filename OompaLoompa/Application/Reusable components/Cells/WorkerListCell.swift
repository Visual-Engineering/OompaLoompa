//
//  WorkerListCell.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

class WorkerListCell: UITableViewCell {

    //MARK: - Stored properties
    fileprivate let photoImageView = UIImageView()
    fileprivate let genderImageView = UIImageView()
    fileprivate let nameLabel = UILabel()
    fileprivate let emailLabel = UILabel()
    fileprivate let professionLabel = UILabel()
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing

        return stackView
    }()

    //MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -

    //MARK: - Private API
    private func layout() {
        contentView.addSubviewWithAutolayout(photoImageView)
        contentView.addSubviewWithAutolayout(infoStackView)

        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(emailLabel)
        infoStackView.addArrangedSubview(professionLabel)

        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        photoImageView.topAnchor.constraint(greaterThanOrEqualTo: infoStackView.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: infoStackView.bottomAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: infoStackView.centerYAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor).isActive = true
        photoImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0).isActive = true

        infoStackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20.0).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0).isActive = true
    }
}

extension WorkerListCell: ReusableView { }

extension WorkerListCell: ViewModelConfigurable {

    func configure(forViewModel viewModel: WorkerViewModel) {
        //Photo image view
        if let url = URL(string: viewModel.thumbnailURLPath), let data = try? Data(contentsOf: url) {
            photoImageView.image = UIImage(data: data)
        } else {
            //Set placeholder
        }

        //Name label
        nameLabel.text = viewModel.name
        nameLabel.textAlignment = .right
        emailLabel.font = UIFont.systemFont(ofSize: 16.0)

        //Email label
        emailLabel.text = viewModel.email
        emailLabel.textAlignment = .right
        emailLabel.font = UIFont.systemFont(ofSize: 14.0)

        //Profession label
        professionLabel.text = viewModel.profession
        professionLabel.textAlignment = .right
        professionLabel.font = UIFont.systemFont(ofSize: 13.0)
        professionLabel.textColor = UIColor.darkGray
    }
}

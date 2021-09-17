//
//  PRViewCell.swift
//  itau
//
//  Created by André Lucas on 14/09/21.
//

import UIKit

final class PRViewCell: UITableViewCell {

    var container: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    var repoInfo: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        return stackView
    }()
    
    var repositoryNameLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .blue
        text.font = UIFont.systemFont(ofSize: 18)
        text.numberOfLines = 1
        return text
    }()
    
    var descriptionLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.numberOfLines = 2
        return text
    }()
    
    var containerInfoUser: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    var infoUser: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    var userImageView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40/2
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    var userImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var userGitNameLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .blue
        text.numberOfLines = 1
        return text
    }()
    
    var userNameLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        text.numberOfLines = 1
        return text
    }()
    
    var rowView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfos(_ model: PRModelElement) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "MMM dd,yyyy hh:mm:ss"

        let date: Date? = dateFormatterGet.date(from: model.createdAt ?? "")
        if let dateInfo = date {
            userNameLabel.text = dateFormatter.string(from: dateInfo)
            userNameLabel.isAccessibilityElement = true
            userNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
            userNameLabel.accessibilityLabel = "Data de criação do repositório \(dateFormatter.string(from: dateInfo))"
        }
        
        if let title = model.title, let userGit = model.user?.login {
            
            repositoryNameLabel.text = title
            repositoryNameLabel.isAccessibilityElement = true
            repositoryNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
            repositoryNameLabel.accessibilityLabel = "Título repositório \(title)"
            
            userGitNameLabel.text = userGit
            userGitNameLabel.isAccessibilityElement = true
            userGitNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
            userGitNameLabel.accessibilityLabel = "Usuário github \(userGit)"
        }

        if let description = model.body, !description.isEmpty {
            descriptionLabel.text = description
            descriptionLabel.isAccessibilityElement = true
            descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
            descriptionLabel.accessibilityLabel = "Descrição repositório \(description)"
        } else {
            descriptionLabel.isHidden = true
        }
        
        if let urlPhoto = URL(string: model.user?.avatarURL ?? "") {
            guard let id = model.user?.id else { return }
            userImage.isAccessibilityElement = true
            userImage.accessibilityLabel = "Imagem Usuário"
            WebImageManager.instance.downloadImage(url: urlPhoto, identifier: String(id) as NSString, imageViewField: userImage) {}
        }
        
    }
}

extension PRViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([container])
        container.addArrangeSubViews([repoInfo, containerInfoUser])
        containerInfoUser.addArrangeSubViews([userImageView, infoUser])
        repoInfo.addArrangeSubViews([repositoryNameLabel, descriptionLabel])
        infoUser.addArrangeSubViews([ userGitNameLabel, userNameLabel])
        userImageView.addSubViews([userImage])
    }
    
    func setupConstraints() {
        [
            container.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),

            userImageView.heightAnchor.constraint(equalToConstant: 40),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            
            userImage.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userImage.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 40),
            userImage.widthAnchor.constraint(equalToConstant: 40),
        
        ].activate()
    }
    
    func configureViews() {
        isUserInteractionEnabled = false
    }
}

//
//  JavaRepoPopListCell.swift
//  itau
//
//  Created by André Lucas on 12/09/21.
//

import UIKit

final class JavaRepoPopListCell: UITableViewCell {

    var container: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    var repoInfo: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 3
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
    
    var containerForkAndStar: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var containerFork: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    var forkImageView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var forkImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor(hexString: "#ff6600")
        return image
    }()
    
    var forkLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor(hexString: "#ff6600")
        text.numberOfLines = 1
        return text
    }()
    
    var containerStars: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    var starsImageView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var starsImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var starsLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor(hexString: "#ff6600")
        text.numberOfLines = 1
        return text
    }()
    
    var infoUser: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
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
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var userGitNameLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .blue
        text.numberOfLines = 0
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfos(_ model: Item) {
        if let name = model.name {
            repositoryNameLabel.text = model.name
            repositoryNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
            repositoryNameLabel.accessibilityLabel = "Nome Repositório \(name)"
            repositoryNameLabel.isAccessibilityElement = true
            
        }

        if let itemDescription = model.itemDescription {
            descriptionLabel.text = model.itemDescription
            descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
            descriptionLabel.accessibilityLabel = "Descrição Repositório \(itemDescription)"
            descriptionLabel.isAccessibilityElement = true
        }
        
        forkLabel.isAccessibilityElement = true
        forkLabel.font = UIFont.preferredFont(forTextStyle: .body)
        if let forks = model.forks {
            forkLabel.text = String(forks)
            forkLabel.accessibilityLabel = "Quantidade de forks no repositório \(forks)"
        } else {
            forkLabel.text = String(0)
            forkLabel.accessibilityLabel = "Quantidade de forks no repositório \(0)"
        }
        starsLabel.isAccessibilityElement = true
        starsLabel.font = UIFont.preferredFont(forTextStyle: .body)
        if let stars = model.stargazersCount {
            starsLabel.text = String(stars)
            starsLabel.accessibilityLabel = "Quantidade de estrelas no repositório \(stars)"
        } else {
            starsLabel.text = String(0)
            starsLabel.accessibilityLabel = "Quantidade de estrelas no repositório \(0)"
        }
        userGitNameLabel.isAccessibilityElement = true
        userGitNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        if let userLogin = model.owner?.userLogin {
            userGitNameLabel.text = String(userLogin)
            userGitNameLabel.accessibilityLabel = "Nome usuário \(userLogin)"
        }
        
        forkImage.image = UIImage(named: "fork")
        forkImage.image = forkImage.image?.withRenderingMode(.alwaysTemplate)
        forkImage.tintColor = UIColor(hexString: "#ff6600")
        
        starsImage.image = UIImage(named: "estrela")
        starsImage.image = starsImage.image?.withRenderingMode(.alwaysTemplate)
        starsImage.tintColor = UIColor(hexString: "#ff6600")
        
        if let urlPhoto = URL(string: model.owner?.avatarURL ?? "") {
            userImage.isAccessibilityElement = true
            userImage.accessibilityLabel = "Imagem Usuário"
            WebImageManager.instance.downloadImage(url: urlPhoto, identifier: String(model.name ?? "") as NSString, imageViewField: userImage) {}
        }
        
    }
}

extension JavaRepoPopListCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([container])
        container.addArrangeSubViews([repoInfo, infoUser])
        repoInfo.addArrangeSubViews([repositoryNameLabel, descriptionLabel, containerForkAndStar])
        containerForkAndStar.addSubViews([containerFork, containerStars])
        
        containerFork.addArrangeSubViews([forkImageView,forkLabel])
        forkImageView.addSubViews([forkImage])
        
        containerStars.addArrangeSubViews([starsImageView, starsLabel])
        starsImageView.addSubViews([starsImage])
        infoUser.addArrangeSubViews([userImageView, userGitNameLabel])
        userImageView.addSubViews([userImage])
    }
    
    func setupConstraints() {
        [
            
            container.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            infoUser.widthAnchor.constraint(equalToConstant: 100),

            userImageView.heightAnchor.constraint(equalToConstant: 40),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            
            userImage.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userImage.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 40),
            userImage.widthAnchor.constraint(equalToConstant: 40),
            
            containerFork.topAnchor.constraint(equalTo: containerForkAndStar.topAnchor),
            containerFork.leadingAnchor.constraint(equalTo: containerForkAndStar.leadingAnchor),
            
            containerStars.topAnchor.constraint(equalTo: containerForkAndStar.topAnchor),
            containerStars.leadingAnchor.constraint(equalTo: containerFork.trailingAnchor, constant: 5),
            
            forkImageView.widthAnchor.constraint(equalToConstant: 15),
            
            forkImage.centerYAnchor.constraint(equalTo: forkImageView.centerYAnchor),
            forkImage.centerXAnchor.constraint(equalTo: forkImageView.centerXAnchor),
            forkImage.heightAnchor.constraint(equalToConstant: 15),
            forkImage.widthAnchor.constraint(equalToConstant: 15),
            
            starsImageView.widthAnchor.constraint(equalToConstant: 15),
            
            starsImage.centerYAnchor.constraint(equalTo: starsImageView.centerYAnchor),
            starsImage.centerXAnchor.constraint(equalTo: starsImageView.centerXAnchor),
            starsImage.heightAnchor.constraint(equalToConstant: 15),
            starsImage.widthAnchor.constraint(equalToConstant: 15)
            
        ].activate()
    }
    
    func configureViews() {
    }
}

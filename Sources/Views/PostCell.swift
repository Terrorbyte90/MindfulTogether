import UIKit

class PostCell: UITableViewCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let categoryLabel = UILabel()
    private let authorLabel = UILabel()
    private let likesLabel = UILabel()
    private let iconView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        iconView.tintColor = UIColor(hex: "#7C3AED")
        iconView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconView)

        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor(hex: "#4C4C4C")
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)

        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.textColor = UIColor(hex: "#6B7280")
        contentLabel.numberOfLines = 2
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentLabel)

        categoryLabel.font = .systemFont(ofSize: 12, weight: .medium)
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = UIColor(hex: "#7C3AED")
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.clipsToBounds = true
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(categoryLabel)

        authorLabel.font = .systemFont(ofSize: 12)
        authorLabel.textColor = UIColor(hex: "#9CA3AF")
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(authorLabel)

        likesLabel.font = .systemFont(ofSize: 12)
        likesLabel.textColor = UIColor(hex: "#9CA3AF")
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(likesLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            iconView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            categoryLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            authorLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 8),
            likesLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(greaterThanOrEqualTo: categoryLabel.bottomAnchor, constant: 12)
        ])
    }

    func configure(with post: ForumPost) {
        titleLabel.text = post.title
        contentLabel.text = post.content
        categoryLabel.text = "  \(post.category.rawValue)  "
        categoryLabel.backgroundColor = UIColor(hex: post.category.color)
        authorLabel.text = post.authorName
        likesLabel.text = "❤️ \(post.likes)"
        iconView.image = UIImage(systemName: post.category.icon)
        iconView.tintColor = UIColor(hex: post.category.color)
    }
}
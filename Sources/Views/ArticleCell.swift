import UIKit

class ArticleCell: UITableViewCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let categoryLabel = UILabel()
    private let helpfulLabel = UILabel()

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

        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor(hex: "#4C4C4C")
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)

        summaryLabel.font = .systemFont(ofSize: 14)
        summaryLabel.textColor = UIColor(hex: "#6B7280")
        summaryLabel.numberOfLines = 2
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(summaryLabel)

        categoryLabel.font = .systemFont(ofSize: 12, weight: .medium)
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = UIColor(hex: "#7C3AED")
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.clipsToBounds = true
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(categoryLabel)

        helpfulLabel.font = .systemFont(ofSize: 12)
        helpfulLabel.textColor = UIColor(hex: "#9CA3AF")
        helpfulLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(helpfulLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            summaryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            categoryLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            helpfulLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            helpfulLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(greaterThanOrEqualTo: categoryLabel.bottomAnchor, constant: 12)
        ])
    }

    func configure(with article: KnowledgeArticle) {
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        categoryLabel.text = "  \(article.category.rawValue)  "
        categoryLabel.backgroundColor = UIColor(hex: article.category.color)
        helpfulLabel.text = "👍 \(article.helpfulCount)"
    }
}
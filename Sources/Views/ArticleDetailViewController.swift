import UIKit

class ArticleDetailViewController: UIViewController {
    private let article: KnowledgeArticle
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let sourceLabel = UILabel()
    private let contentLabel = UILabel()
    private let helpfulButton = UIButton(type: .system)

    init(article: KnowledgeArticle) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Artikel"
        view.backgroundColor = UIColor(hex: "#F5F3FF")

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        titleLabel.text = article.title
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(hex: "#4C4C4C")
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        categoryLabel.text = "  \(article.category.rawValue)  "
        categoryLabel.font = .systemFont(ofSize: 12, weight: .medium)
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = UIColor(hex: article.category.color)
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.clipsToBounds = true
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)

        sourceLabel.text = " Källa: \(article.source)"
        sourceLabel.font = .systemFont(ofSize: 12)
        sourceLabel.textColor = UIColor(hex: "#9CA3AF")
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sourceLabel)

        contentLabel.text = article.content
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.textColor = UIColor(hex: "#4C4C4C")
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentLabel)

        helpfulButton.setTitle("  👍 Hjälpsam (\(article.helpfulCount))", for: .normal)
        helpfulButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        helpfulButton.backgroundColor = UIColor(hex: "#7C3AED")
        helpfulButton.setTitleColor(.white, for: .normal)
        helpfulButton.layer.cornerRadius = 12
        helpfulButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(helpfulButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 24),
            sourceLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            sourceLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 8),
            contentLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 24),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            helpfulButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 24),
            helpfulButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            helpfulButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            helpfulButton.heightAnchor.constraint(equalToConstant: 50),
            helpfulButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
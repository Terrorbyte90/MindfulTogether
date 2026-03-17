import UIKit

class PostDetailViewController: UIViewController {
    private let post: ForumPost
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let categoryLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let repliesLabel = UILabel()
    private let tableView = UITableView()

    init(post: ForumPost) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Inlägg"
        view.backgroundColor = UIColor(hex: "#F5F3FF")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Svara", style: .plain, target: self, action: #selector(replyTapped))

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        titleLabel.text = post.title
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = UIColor(hex: "#4C4C4C")
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        contentLabel.text = post.content
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.textColor = UIColor(hex: "#4C4C4C")
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentLabel)

        categoryLabel.text = "  \(post.category.rawValue)  "
        categoryLabel.font = .systemFont(ofSize: 12, weight: .medium)
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = UIColor(hex: post.category.color)
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.clipsToBounds = true
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)

        authorLabel.text = "Av \(post.authorName)"
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = UIColor(hex: "#6B7280")
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)

        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy, HH:mm"
        dateLabel.text = formatter.string(from: post.createdAt)
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = UIColor(hex: "#9CA3AF")
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)

        repliesLabel.text = "Svar (\(post.replies.count))"
        repliesLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        repliesLabel.textColor = UIColor(hex: "#4C4C4C")
        repliesLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(repliesLabel)

        tableView.register(ReplyCell.self, forCellReuseIdentifier: "ReplyCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)

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
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 24),
            authorLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 8),
            repliesLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 24),
            repliesLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: repliesLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(max(post.replies.count, 1)) * 100),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    @objc private func replyTapped() {
        let alert = UIAlertController(title: "Svara", message: "Skriv ditt svar", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Ditt svar..."
        }
        alert.addAction(UIAlertAction(title: "Skicka", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                let reply = Reply(authorId: UUID(), authorName: DataManager.shared.currentUser.displayName, content: text)
                var updatedPost = self.post
                updatedPost.replies.append(reply)
            }
        })
        alert.addAction(UIAlertAction(title: "Avbryt", style: .cancel))
        present(alert, animated: true)
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { max(post.replies.count, 1) }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as! ReplyCell
        if post.replies.isEmpty {
            cell.configureEmpty()
        } else {
            cell.configure(with: post.replies[indexPath.row])
        }
        return cell
    }
}
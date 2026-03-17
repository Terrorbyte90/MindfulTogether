import UIKit

class HomeViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let welcomeLabel = UILabel()
    private let crisisButton = UIButton(type: .system)
    private let recentPostsLabel = UILabel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Hem"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(hex: "#F5F3FF")

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        welcomeLabel.text = "Välkommen till MindfulTogether 💜"
        welcomeLabel.font = .systemFont(ofSize: 24, weight: .bold)
        welcomeLabel.textColor = UIColor(hex: "#4C4C4C")
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(welcomeLabel)

        crisisButton.setTitle("🆘 Krishjälp", for: .normal)
        crisisButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        crisisButton.backgroundColor = UIColor(hex: "#DC2626")
        crisisButton.setTitleColor(.white, for: .normal)
        crisisButton.layer.cornerRadius = 12
        crisisButton.translatesAutoresizingMaskIntoConstraints = false
        crisisButton.addTarget(self, action: #selector(crisisTapped), for: .touchUpInside)
        contentView.addSubview(crisisButton)

        recentPostsLabel.text = "Aktiva trådar"
        recentPostsLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        recentPostsLabel.textColor = UIColor(hex: "#4C4C4C")
        recentPostsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recentPostsLabel)

        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)

        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            crisisButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            crisisButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            crisisButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            crisisButton.heightAnchor.constraint(equalToConstant: 50),

            recentPostsLabel.topAnchor.constraint(equalTo: crisisButton.bottomAnchor, constant: 24),
            recentPostsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            tableView.topAnchor.constraint(equalTo: recentPostsLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 400),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    @objc private func crisisTapped() {
        let alert = UIAlertController(title: "Krishjälp", message: "Om du har akuta tankar på att skada dig själv, ring 112 eller Mind SVAR: 020-80 60 00", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ring 112", style: .destructive) { _ in
            if let url = URL(string: "tel://112") { UIApplication.shared.open(url) }
        })
        alert.addAction(UIAlertAction(title: "Mind SVAR", style: .default) { _ in
            if let url = URL(string: "tel://020806000") { UIApplication.shared.open(url) }
        })
        alert.addAction(UIAlertAction(title: "Stäng", style: .cancel))
        present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.recentPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.configure(with: DataManager.shared.recentPosts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = DataManager.shared.recentPosts[indexPath.row]
        let detailVC = PostDetailViewController(post: post)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
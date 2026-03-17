import UIKit

class ProfileViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let avatarView = UIView()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let bioLabel = UILabel()
    private let statsStackView = UIStackView()
    private let editButton = UIButton(type: .system)
    private let settingsTableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Profil"
        view.backgroundColor = UIColor(hex: "#F5F3FF")

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        avatarView.backgroundColor = UIColor(hex: "#DDD6FE")
        avatarView.layer.cornerRadius = 50
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarView)

        let user = DataManager.shared.currentUser
        nameLabel.text = user.displayName
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.textColor = UIColor(hex: "#4C4C4C")
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        usernameLabel.text = "@" + user.username
        usernameLabel.font = .systemFont(ofSize: 16)
        usernameLabel.textColor = UIColor(hex: "#6B7280")
        usernameLabel.textAlignment = .center
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(usernameLabel)

        bioLabel.text = user.bio
        bioLabel.font = .systemFont(ofSize: 16)
        bioLabel.textColor = UIColor(hex: "#4C4C4C")
        bioLabel.textAlignment = .center
        bioLabel.numberOfLines = 0
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bioLabel)

        statsStackView.axis = .horizontal
        statsStackView.distribution = .equalSpacing
        statsStackView.spacing = 32
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statsStackView)

        let postsStat = createStatView(value: "\(user.postCount)", label: "Inlägg")
        let helpStat = createStatView(value: "\(user.helpfulCount)", label: "Hjälpsam")
        let topicStat = createStatView(value: "\(user.topics.count)", label: "Ämnen")
        statsStackView.addArrangedSubview(postsStat)
        statsStackView.addArrangedSubview(helpStat)
        statsStackView.addArrangedSubview(topicStat)

        editButton.setTitle("Redigera profil", for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        editButton.backgroundColor = UIColor(hex: "#7C3AED")
        editButton.setTitleColor(.white, for: .normal)
        editButton.layer.cornerRadius = 8
        editButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(editButton)

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.backgroundColor = .clear
        settingsTableView.isScrollEnabled = false
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(settingsTableView)

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
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            avatarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 100),
            avatarView.heightAnchor.constraint(equalToConstant: 100),
            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            usernameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            statsStackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 24),
            statsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            editButton.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 24),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            editButton.heightAnchor.constraint(equalToConstant: 44),
            settingsTableView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 16),
            settingsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            settingsTableView.heightAnchor.constraint(equalToConstant: 200),
            settingsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func createStatView(value: String, label: String) -> UIView {
        let container = UIView()
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        valueLabel.textColor = UIColor(hex: "#4C4C4C")
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(valueLabel)

        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = UIColor(hex: "#6B7280")
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(textLabel)

        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: container.topAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            textLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        return container
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 4 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Anonymitetsinställningar"
        case 1: cell.textLabel?.text = "Notifikationer"
        case 2: cell.textLabel?.text = "Hjälp & Support"
        case 3: cell.textLabel?.text = "Logga ut"
        default: break
        }
        return cell
    }
}

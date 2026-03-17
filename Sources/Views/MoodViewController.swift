import UIKit

class MoodViewController: UIViewController {
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let moodStackView = UIStackView()
    private var selectedMood: MoodLevel?
    private let noteTextView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let historyLabel = UILabel()
    private let historyTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Mående"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(hex: "#F5F3FF")

        titleLabel.text = "Hur mår du idag?"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(hex: "#4C4C4C")
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM"
        dateLabel.text = formatter.string(from: Date())
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = UIColor(hex: "#6B7280")
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)

        moodStackView.axis = .horizontal
        moodStackView.distribution = .equalSpacing
        moodStackView.alignment = .center
        moodStackView.spacing = 8
        moodStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moodStackView)

        for mood in MoodLevel.allCases {
            let button = UIButton(type: .system)
            button.setTitle(mood.emoji, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 40)
            button.tag = mood.rawValue
            button.addTarget(self, action: #selector(moodTapped(_:)), for: .touchUpInside)
            moodStackView.addArrangedSubview(button)
        }

        noteTextView.placeholder = "Lägg till en anteckning (valfritt)..."
        noteTextView.font = .systemFont(ofSize: 16)
        noteTextView.backgroundColor = .white
        noteTextView.layer.cornerRadius = 12
        noteTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noteTextView)

        saveButton.setTitle("Spara", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        saveButton.backgroundColor = UIColor(hex: "#7C3AED")
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 12
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)

        historyLabel.text = "Historik"
        historyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        historyLabel.textColor = UIColor(hex: "#4C4C4C")
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(historyLabel)

        historyTableView.register(MoodHistoryCell.self, forCellReuseIdentifier: "MoodHistoryCell")
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.backgroundColor = .clear
        historyTableView.separatorStyle = .none
        historyTableView.isScrollEnabled = false
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(historyTableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moodStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            moodStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            moodStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            noteTextView.topAnchor.constraint(equalTo: moodStackView.bottomAnchor, constant: 24),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteTextView.heightAnchor.constraint(equalToConstant: 100),
            saveButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            historyLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 24),
            historyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            historyTableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 12),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyTableView.heightAnchor.constraint(equalToConstant: 200),
            historyTableView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }

    @objc private func moodTapped(_ sender: UIButton) {
        selectedMood = MoodLevel(rawValue: sender.tag)
    }

    @objc private func saveTapped() {
        guard let mood = selectedMood else {
            let alert = UIAlertController(title: "Välj ett mående", message: "Tryck på en emoji för att välja hur du mår.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let entry = MoodEntry(date: Date(), mood: mood, note: noteTextView.text ?? "")
        DataManager.shared.moodEntries.insert(entry, at: 0)
        let alert = UIAlertController(title: "Sparat!", message: "Ditt mående har sparats.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        historyTableView.reloadData()
    }
}

extension MoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { min(DataManager.shared.moodEntries.count, 5) }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoodHistoryCell", for: indexPath) as! MoodHistoryCell
        cell.configure(with: DataManager.shared.moodEntries[indexPath.row])
        return cell
    }
}

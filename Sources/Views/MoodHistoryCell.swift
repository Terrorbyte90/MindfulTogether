import UIKit

class MoodHistoryCell: UITableViewCell {
    private let containerView = UIView()
    private let emojiLabel = UILabel()
    private let dateLabel = UILabel()
    private let moodLabel = UILabel()
    private let noteLabel = UILabel()

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

        emojiLabel.font = .systemFont(ofSize: 32)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(emojiLabel)

        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dateLabel.textColor = UIColor(hex: "#4C4C4C")
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dateLabel)

        moodLabel.font = .systemFont(ofSize: 14)
        moodLabel.textColor = UIColor(hex: "#6B7280")
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(moodLabel)

        noteLabel.font = .systemFont(ofSize: 12)
        noteLabel.textColor = UIColor(hex: "#9CA3AF")
        noteLabel.numberOfLines = 1
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(noteLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            emojiLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            emojiLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 12),
            moodLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            moodLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            noteLabel.topAnchor.constraint(equalTo: moodLabel.bottomAnchor, constant: 4),
            noteLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            noteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            noteLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with entry: MoodEntry) {
        emojiLabel.text = entry.mood.emoji
        moodLabel.text = entry.mood.label
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMM"
        dateLabel.text = formatter.string(from: entry.date)
        
        noteLabel.text = entry.note.isEmpty ? "Ingen anteckning" : entry.note
    }
}
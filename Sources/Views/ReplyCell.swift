import UIKit

class ReplyCell: UITableViewCell {
    private let containerView = UIView()
    private let authorLabel = UILabel()
    private let contentLabel = UILabel()
    private let dateLabel = UILabel()
    private let likesLabel = UILabel()

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

        authorLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        authorLabel.textColor = UIColor(hex: "#4C4C4C")
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(authorLabel)

        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.textColor = UIColor(hex: "#4C4C4C")
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentLabel)

        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = UIColor(hex: "#9CA3AF")
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dateLabel)

        likesLabel.font = .systemFont(ofSize: 12)
        likesLabel.textColor = UIColor(hex: "#9CA3AF")
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(likesLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            authorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            authorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            contentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            dateLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            likesLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
    }

    func configure(with reply: Reply) {
        authorLabel.text = reply.authorName
        contentLabel.text = reply.content
        likesLabel.text = "❤️ \(reply.likes)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM HH:mm"
        dateLabel.text = formatter.string(from: reply.createdAt)
    }

    func configureEmpty() {
        authorLabel.text = "Inga svar än"
        contentLabel.text = "Var den första att svara på detta inlägg!"
        dateLabel.text = ""
        likesLabel.text = ""
    }
}
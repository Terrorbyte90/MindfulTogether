import UIKit

class CategoryCell: UICollectionViewCell {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with category: PostCategory) {
        label.text = category.rawValue
        contentView.backgroundColor = UIColor(hex: category.color).withAlphaComponent(0.15)
        contentView.layer.borderColor = UIColor(hex: category.color).cgColor
        label.textColor = UIColor(hex: category.color)
    }
    
    func configure(with text: String, colorHex: String) {
        label.text = text
        contentView.backgroundColor = UIColor(hex: colorHex).withAlphaComponent(0.15)
        contentView.layer.borderColor = UIColor(hex: colorHex).cgColor
        label.textColor = UIColor(hex: colorHex)
    }
}
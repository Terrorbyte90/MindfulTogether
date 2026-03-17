import UIKit

class CreatePostViewController: UIViewController {
    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    private let categoryPicker = UIPickerView()
    private let postButton = UIButton(type: .system)
    private var selectedCategory: PostCategory = .general

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Nytt inlägg"
        view.backgroundColor = UIColor(hex: "#F5F3FF")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))

        let titleLabel = UILabel()
        titleLabel.text = "Titel"
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = UIColor(hex: "#6B7280")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        titleTextField.placeholder = "Skriv en titel..."
        titleTextField.font = .systemFont(ofSize: 16)
        titleTextField.backgroundColor = .white
        titleTextField.layer.cornerRadius = 8
        titleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        titleTextField.leftViewMode = .always
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)

        let categoryLabel = UILabel()
        categoryLabel.text = "Kategori"
        categoryLabel.font = .systemFont(ofSize: 14, weight: .medium)
        categoryLabel.textColor = UIColor(hex: "#6B7280")
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryLabel)

        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryPicker)

        let contentLabel = UILabel()
        contentLabel.text = "Innehåll"
        contentLabel.font = .systemFont(ofSize: 14, weight: .medium)
        contentLabel.textColor = UIColor(hex: "#6B7280")
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentLabel)

        contentTextView.font = .systemFont(ofSize: 16)
        contentTextView.backgroundColor = .white
        contentTextView.layer.cornerRadius = 8
        contentTextView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTextView)

        postButton.setTitle("Publicera", for: .normal)
        postButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        postButton.backgroundColor = UIColor(hex: "#7C3AED")
        postButton.setTitleColor(.white, for: .normal)
        postButton.layer.cornerRadius = 12
        postButton.addTarget(self, action: #selector(postTapped), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            categoryLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryPicker.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryPicker.heightAnchor.constraint(equalToConstant: 120),
            contentLabel.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 16),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTextView.heightAnchor.constraint(equalToConstant: 150),
            postButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 24),
            postButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            postButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }

    @objc private func postTapped() {
        guard let title = titleTextField.text, !title.isEmpty, let content = contentTextView.text, !content.isEmpty else {
            let alert = UIAlertController(title: "Fel", message: "Fyll i både titel och innehåll", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let post = ForumPost(authorId: UUID(), authorName: DataManager.shared.currentUser.displayName, title: title, content: content, category: selectedCategory)
        DataManager.shared.addPost(post)
        dismiss(animated: true)
    }
}

extension CreatePostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { PostCategory.allCases.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { PostCategory.allCases[row].rawValue }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = PostCategory.allCases[row]
    }
}
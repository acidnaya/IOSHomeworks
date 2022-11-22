//
//  AddNoteCell.swift
//  merubtsovaPW2
//
//  Created by Maria Rubtsova on 22.11.2022.
//

import Foundation
import UIKit

protocol AddNoteDelegate {
	func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell {
	static let reuseIdentifier = "AddNoteCell"
	private var textView = UITextView()
	public var addButton = UIButton()
	public var delegate: AddNoteDelegate?
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.selectionStyle = .none
		setupView()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		textView.font = .systemFont(ofSize: 14, weight: .regular)
		textView.textColor = .tertiaryLabel
		textView.backgroundColor = .clear
		textView.setHeight(140)
		addButton.setTitle("Add new note", for: .normal)
		addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
		addButton.setTitleColor(.systemBackground, for: .normal)
		addButton.backgroundColor = .label
		addButton.layer.cornerRadius = 8
		addButton.setHeight(44)
		addButton.addTarget(self, action: #selector(addButtonTapped),
							for: .touchUpInside)
		//addButton.isEnabled = false
		addButton.alpha = 0.5
		let stackView = UIStackView(arrangedSubviews: [textView, addButton])
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.distribution = .fill
		contentView.addSubview(stackView)
		stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
		contentView.backgroundColor = .systemGray5
	}
	
	@objc
	private func addButtonTapped() {
		if (textView.text.isEmpty) {
			return
		}
		delegate?.newNoteAdded(note: ShortNote(text: textView.text))
	}

}

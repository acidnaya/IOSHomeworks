//
//  ColorPaletteView.swift
//  merubtsovaPW2
//
//  Created by Maria Rubtsova on 01.11.2022.
//

import Foundation
import UIKit

class ColorComponents {
	var red: CGFloat = 0.0
	var green: CGFloat = 0.0
	var blue: CGFloat = 0.0
	var alpha: CGFloat = 0.0
	
	init() {
		red = 0.0
		green = 0.0
		blue = 0.0
		alpha = 0.0
	}
	
	init(color: UIColor) {
		color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
	}
}

final class ColorPaletteView: UIControl {
	private let stackView = UIStackView()
	private(set) var chosenColor: UIColor = .systemGray6
	private var redControl: ColorSliderView
	private var greenControl: ColorSliderView
	private var blueControl: ColorSliderView
	
	init() {
		let components = ColorComponents(color: chosenColor)
		redControl = ColorSliderView(colorName: "R", value:
											Float(components.red))
		greenControl = ColorSliderView(colorName: "G", value:
											Float(components.green))
		blueControl = ColorSliderView(colorName: "B", value:
											Float(components.blue))
		super.init(frame: .zero)
		setupView()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		redControl.tag = 0
		greenControl.tag = 1
		blueControl.tag = 2
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.addArrangedSubview(redControl)
		stackView.addArrangedSubview(greenControl)
		stackView.addArrangedSubview(blueControl)
		stackView.backgroundColor = .white
		stackView.layer.cornerRadius = 12
		[redControl, greenControl, blueControl].forEach {
			$0.addTarget(self, action: #selector(sliderMoved(slider:)),
						 for: .touchDragInside)
		}
		addSubview(stackView)
		stackView.pin(to: self, [.left: 0, .right: 0, .top: 0, .bottom: 0])
	}
	
	@objc
	private func sliderMoved(slider: ColorSliderView) {
		let components = ColorComponents(color: chosenColor)
		switch slider.tag {
		case 0:
			self.chosenColor = UIColor(
				red: CGFloat(slider.value),
				green: components.green,
				blue: components.blue,
				alpha: components.alpha
			)
		case 1:
			self.chosenColor = UIColor(
				red: components.red,
				green: CGFloat(slider.value),
				blue: components.blue,
				alpha: components.alpha
			)
		default:
			self.chosenColor = UIColor(
				red: components.red,
				green: components.green,
				blue: CGFloat(slider.value),
				alpha: components.alpha
			)
		}
		sendActions(for: .touchDragInside)
	}
}

extension ColorPaletteView: KeepBGColorUpdatedProtocol {
	public func KeepColor(color: UIColor) {
		chosenColor = color
		let components = ColorComponents(color: chosenColor)
		redControl.changeValue(value: Float(components.red))
		greenControl.changeValue(value: Float(components.green))
		blueControl.changeValue(value: Float(components.blue))
	}
	
	private final class ColorSliderView: UIControl {
		private let slider = UISlider()
		private let colorLabel = UILabel()
		private(set) var value: Float
		init(colorName: String, value: Float) {
			self.value = value
			super.init(frame: .zero)
			slider.value = value
			colorLabel.text = colorName
			setupView()
			slider.addTarget(self, action:
								#selector(sliderMoved(_:)), for: .touchDragInside)
		}
		
		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		private func setupView() {
			let stackView = UIStackView(arrangedSubviews:
											[colorLabel, slider])
			stackView.axis = .horizontal
			stackView.spacing = 8
			addSubview(stackView)
			stackView.pin(to: self, [.left: 12, .top: 12, .right:
										12, .bottom: 12])
		}
		
		@objc
		private func sliderMoved(_ slider: UISlider) {
			self.value = slider.value
			sendActions(for: .touchDragInside)
		}

		@objc
		 func changeValue(value: Float) {
			 slider.setValue(value, animated: true)
		}
	}
}

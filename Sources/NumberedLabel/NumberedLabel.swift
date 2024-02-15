//  NumberedLabel.swift
//  Created by Ben Böcker on 15.02.24.

import SwiftUI



public struct NumberedLabel: View {
	public init(title: String, iconName: String? = nil, count: Int? = nil) {
		self.title = title
		self.iconName = iconName
		self.count = count
		self.style = .disabled
		self.size = .medium
	}

	private init(title: String, iconName: String?, count: Int?, size: Size, style: Style) {
		self.title = title
		self.iconName = iconName
		self.size = size
		self.style = style
		self.count = count
	}

	public enum Size {
		case small, medium
	}
	
	public enum Style {
		case filled(Color)
		case tinted(Color)
		case bordered(Color)
		case disabled
	}
	
	private let iconName: String?
	private let title: String
	private let count: Int?
	private let size: Size
	private let style: Style

	public var body: some View {
		HStack(alignment: .firstTextBaseline, spacing: iconSpacing) {
			if let iconName {
				Image(systemName: iconName)
					.font(iconfont)
					.symbolVariant(iconVariant)
			}
			HStack(alignment: .firstTextBaseline) {
				Text(title)
					.font(titlefont)
				
				if let count {
					Text("\(count)")
						.font(countFont)
				}
			}
		}
		.foregroundStyle(foregroundColor)
		.padding(.vertical, verticalPadding)
		.padding(.horizontal, horizontalPadding)
		.frame(minHeight: minHeight)
		.background(alignment: .center) {
			switch style {
			case .filled(let color):
				RoundedRectangle(cornerRadius: cornerRadius)
					.fill(color.gradient)
			case .tinted(let color):
				RoundedRectangle(cornerRadius: cornerRadius)
					.fill(color.quinary)
			case .disabled:
				RoundedRectangle(cornerRadius: cornerRadius)
					.fill(Color.secondary.quinary)
			case .bordered:
				RoundedRectangle(cornerRadius: cornerRadius)
					.stroke(strokeColor, lineWidth: 1.5)
			}
		}
	}
}

public extension NumberedLabel {
	func size(_ size: Size) -> NumberedLabel {
		NumberedLabel(title: title, iconName: iconName, count: count, size: size, style: style)
	}
	
	func style(_ style: Style) -> NumberedLabel {
		NumberedLabel(title: title, iconName: iconName, count: count, size: size, style: style)
	}
}

private extension NumberedLabel {
	var minHeight: CGFloat {
		switch size {
		case .medium: 32
		case .small: 20
		}
	}
	
	var titlefont: Font {
		switch size {
		case .medium: .system(.subheadline, design: .rounded, weight: .semibold)
		case .small: .system(.caption2, design: .rounded, weight: .semibold)
		}
	}
	
	var iconfont: Font {
		switch size {
		case .medium: .system(.footnote, design: .rounded, weight: .semibold)
		case .small: .system(.caption2, design: .rounded, weight: .semibold)
		}
	}
	
	var countFont: Font {
		switch size {
		case .medium: .system(.footnote, weight: .black)
		case .small: .system(.caption2, design: .rounded, weight: .semibold)
		}
	}
	
	var cornerRadius: CGFloat {
		switch size {
		case .medium: 8
		case .small: 6
		}
	}
	
	var iconSpacing: CGFloat {
		switch size {
		case .medium: 6
		case .small: 4
		}
	}
	
	var horizontalPadding: CGFloat {
		switch size {
		case .medium: 8
		case .small: 6
		}
	}
	
	var verticalPadding: CGFloat {
		switch size {
		case .medium: 4
		case .small: 4
		}
	}
	
	var foregroundColor: Color {
		switch style {
		case .filled: Color.white
		case .tinted(let color): color
		case .bordered(let color): color
		case .disabled: Color(white: 0.6)
		}
	}

	var strokeColor: Color {
		switch style {
		case .filled: .clear
		case .tinted: .clear
		case .bordered(let color): color
		case .disabled: .clear
		}
	}
	
	var iconVariant: SymbolVariants {
		switch style {
		case .bordered: .none
		default: .fill
		}
	}
}

private struct PreviewTag: Identifiable {
	let id = UUID()
	let title: String
	let count: Int?
	let color: Color
	let iconName: String?
	
	static let tags = [
		PreviewTag(title: "Arbeit", count: 23, color: .indigo, iconName: "desktopcomputer"),
		PreviewTag(title: "Studium", count: 24, color: .mint, iconName: nil),
		PreviewTag(title: "Haushalt", count: 8, color: .orange, iconName: "house"),
		PreviewTag(title: "Sport", count: nil, color: .cyan, iconName: "sportscourt"),
		PreviewTag(title: "Swift", count: 126, color: .purple, iconName: "swift"),
	]
}


#Preview("Tags Medium", traits: .fixedLayout(width: 700, height: 350)) {
	HStack(spacing: 32) {
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.style(.filled(tag.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.style(.tinted(tag.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.style(.bordered(tag.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.style(.disabled)
			}
		}
	}
	.padding()
}

#Preview("Tags Small", traits: .fixedLayout(width: 700, height: 350)) {
	HStack(spacing: 32) {
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.size(.small)
					.style(.filled(tag.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.size(.small)
					.style(.tinted(tag.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.size(.small)
					.style(.bordered(tag.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewTag.tags) { tag in
				NumberedLabel(title: tag.title, iconName: tag.iconName, count: tag.count)
					.size(.small)
					.style(.disabled)
			}
		}
	}
	.padding()
}

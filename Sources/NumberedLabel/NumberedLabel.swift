//  NumberedLabel.swift
//  Created by Ben Böcker on 15.02.24.

import SwiftUI



public struct NumberedLabel: View {
	public init(title: String?, iconName: String? = nil, count: Int? = nil) {
		self.title = title
		self.iconName = iconName
		self.count = count
	}
	
	private let iconName: String?
	private let title: String?
	private let count: Int?
	
	@Environment(\.numberedLabelSize) private var size
	@Environment(\.numberedLabelStyle) private var style
	@Environment(\.numberedLabelShape) private var shape
	
	public var body: some View {
		HStack(alignment: .center, spacing: size.spacing) {
			if let iconName {
				Image(systemName: iconName)
					.font(size.iconfont)
			}
			if title != nil || count != nil {
				HStack(alignment: .firstTextBaseline) {
					if let title {
						Text(title)
							.font(size.titlefont)
					}
					if let count {
						Text("\(count)")
							.font(size.countFont)
					}
				}
			}
		}
		.foregroundStyle(style.foregroundColor)
		.padding(.vertical, size.verticalPadding)
		.padding(.horizontal, size.horizontalPadding)
		.frame(minHeight: size.minHeight)
		.background(backgroundView)
	}
}


// MARK: - Private properties and functions
private extension NumberedLabel {
	@ViewBuilder var backgroundView: some View {
		switch style {
		case .filled(let color):
			AnyShape(backgroundShape)
				.fill(color.gradient)
		case .tinted(let color):
			AnyShape(backgroundShape)
				.fill(color.quinary)
		case .disabled:
			AnyShape(backgroundShape)
				.fill(Color.secondary.quinary)
		case .bordered where shape == .capsule:
			Capsule()
				.strokeBorder(style.strokeColor, lineWidth: 1.5)
		case .bordered:
			RoundedRectangle(cornerRadius: size.cornerRadius)
				.strokeBorder(style.strokeColor, lineWidth: 1.5)
		}
	}
	
	var backgroundShape: any SwiftUI.Shape {
		switch shape {
		case .roundedRect: 
			RoundedRectangle(cornerRadius: size.cornerRadius)
		case .capsule:
			Capsule()
		}
	}
}


private struct PreviewData: Identifiable {
	let id = UUID()
	let title: String
	let count: Int?
	let color: Color
	let iconName: String?
	
	static let data = [
		PreviewData(title: "Work", count: 23, color: .indigo, iconName: "desktopcomputer"),
		PreviewData(title: "University", count: 24, color: .mint, iconName: nil),
		PreviewData(title: "Household", count: 8, color: .orange, iconName: "house"),
		PreviewData(title: "Sports", count: nil, color: .cyan, iconName: "sportscourt"),
		PreviewData(title: "Swift", count: 126, color: .purple, iconName: "swift"),
	]
}


#Preview("Medium", traits: .fixedLayout(width: 750, height: 350)) {
	HStack(spacing: 32) {
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.filled(data.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.tinted(data.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.bordered(data.color))
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.disabled)
			}
		}
	}
	.padding()
}

#Preview("Small", traits: .fixedLayout(width: 700, height: 350)) {
	HStack(spacing: 32) {
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.filled(data.color))
					.numberedLabelSize(.small)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.tinted(data.color))
					.numberedLabelSize(.small)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.bordered(data.color))
					.numberedLabelSize(.small)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.disabled)
					.numberedLabelSize(.small)
			}
		}
	}
	.padding()
}

#Preview("Capsule Medium", traits: .fixedLayout(width: 800, height: 350)) {
	HStack(spacing: 32) {
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.filled(data.color))
					.numberedLabelShape(.capsule)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.tinted(data.color))
					.numberedLabelShape(.capsule)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.bordered(data.color))
					.numberedLabelShape(.capsule)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.disabled)
					.numberedLabelShape(.capsule)
			}
		}
	}
	.padding()
}

#Preview("Capsule Small", traits: .fixedLayout(width: 800, height: 350)) {
	HStack(spacing: 32) {
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.filled(data.color))
					.numberedLabelSize(.small)
					.numberedLabelShape(.capsule)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.tinted(data.color))
					.numberedLabelSize(.small)
					.numberedLabelShape(.capsule)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.bordered(data.color))
					.numberedLabelSize(.small)
					.numberedLabelShape(.capsule)
			}
		}
		VStack(spacing: 32) {
			ForEach(PreviewData.data) { data in
				NumberedLabel(title: data.title, iconName: data.iconName, count: data.count)
					.numberedLabelStyle(.disabled)
					.numberedLabelSize(.small)
					.numberedLabelShape(.capsule)
			}
		}
	}
	.padding()
}


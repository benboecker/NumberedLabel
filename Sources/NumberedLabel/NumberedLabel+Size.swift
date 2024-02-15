//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 15.02.24.
//

import Foundation
import SwiftUI



// MARK: - NumberedLabel size
public extension NumberedLabel {
	enum Size {
		case small, medium
	}
}


extension NumberedLabel.Size {
	var minHeight: CGFloat {
		switch self {
		case .medium: 32
		case .small: 20
		}
	}
	
	var titlefont: Font {
		switch self {
		case .medium: .system(.subheadline, design: .rounded, weight: .semibold)
		case .small: .system(.caption2, design: .rounded, weight: .semibold)
		}
	}
	
	var iconfont: Font {
		switch self {
		case .medium: .system(.footnote, design: .rounded, weight: .semibold)
		case .small: .system(.caption2, design: .rounded, weight: .semibold)
		}
	}
	
	var countFont: Font {
		switch self {
		case .medium: .system(.footnote, weight: .black)
		case .small: .system(.caption2, design: .rounded, weight: .semibold)
		}
	}
	
	var cornerRadius: CGFloat {
		switch self {
		case .medium: 8
		case .small: 6
		}
	}
	
	var spacing: CGFloat {
		switch self {
		case .medium: 6
		case .small: 4
		}
	}
	
	var horizontalPadding: CGFloat {
		switch self {
		case .medium: 12
		case .small: 10
		}
	}
	
	var verticalPadding: CGFloat {
		switch self {
		case .medium: 6
		case .small: 5
		}
	}
}


public extension View {
	func numberedLabelSize(_ size: NumberedLabel.Size) -> some View {
		environment(\.numberedLabelSize, size)
	}
}


private struct NumberedLabelSizeEnvironmentKey: EnvironmentKey {
	static var defaultValue: NumberedLabel.Size = .medium
}


extension EnvironmentValues {
	var numberedLabelSize: NumberedLabel.Size {
		get { self[NumberedLabelSizeEnvironmentKey.self] }
		set { self[NumberedLabelSizeEnvironmentKey.self] = newValue }
	}
}

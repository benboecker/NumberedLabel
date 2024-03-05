//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 15.02.24.
//

import SwiftUI



// MARK: - NumberedLabel style
public extension NumberedLabel {
	enum Style {
		case filled(Color)
		case tinted(Color)
		case bordered(Color)
		case disabled
	}
}


extension NumberedLabel.Style {
	var foregroundColor: Color {
		switch self {
		case .filled: Color.white
		case .tinted(let color): color
		case .bordered(let color): color
		case .disabled: Color(white: 0.6)
		}
	}

	var strokeColor: Color {
		switch self {
		case .filled: .clear
		case .tinted: .clear
		case .bordered(let color): color
		case .disabled: .clear
		}
	}
	
	var iconVariant: SymbolVariants {
		switch self {
		case .bordered: .none
		default: .fill
		}
	}
}


// MARK: - Public modifiers
public extension View {
	func numberedLabelStyle(_ style: NumberedLabel.Style) -> some View {
		environment(\.numberedLabelStyle, style)
	}
}


private struct NumberedLabelStyleEnvironmentKey: EnvironmentKey {
	static var defaultValue: NumberedLabel.Style = .tinted(.accentColor)
}


extension EnvironmentValues {
	var numberedLabelStyle: NumberedLabel.Style {
		get { self[NumberedLabelStyleEnvironmentKey.self] }
		set { self[NumberedLabelStyleEnvironmentKey.self] = newValue }
	}
}

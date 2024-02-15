//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 15.02.24.
//

import Foundation
import SwiftUI



// MARK: - NumberedLabel shape
public extension NumberedLabel {
	enum Shape {
		case roundedRect, capsule
	}
}


public extension View {
	func numberedLabelShape(_ shape: NumberedLabel.Shape) -> some View {
		environment(\.numberedLabelShape, shape)
	}
}


private struct NumberedLabelShapeEnvironmentKey: EnvironmentKey {
	static var defaultValue: NumberedLabel.Shape = .roundedRect
}


extension EnvironmentValues {
	var numberedLabelShape: NumberedLabel.Shape {
		get { self[NumberedLabelShapeEnvironmentKey.self] }
		set { self[NumberedLabelShapeEnvironmentKey.self] = newValue }
	}
}


//
//  ColorTool.swift
//  JobAppChart
//
//  Created by alex w on 6/5/25.
//

import Foundation
import SwiftUI

/// Class with functions for integrating SwiftUI Colors with the database.
class ColorTool {
    
    /// Creates a SwiftUI Color based on a single RGB value (typically represented in hex).
    ///
    /// - Parameter hexValue: RGB value of the colors, in the form 0x--RRGGBB (or a decimal/binary equivalent). Note the leading 8 bits are ignored.
    /// - Returns: SwiftUI Color from the provided RGB values.
    static func makeColor(_ hexValue: Int32) -> Color {
        let r = Double((hexValue >> 16) & 0xFF) / 255.0
        let g = Double((hexValue >> 8) & 0xFF) / 255.0
        let b = Double((hexValue) & 0xFF) / 255.0
        return Color(red: r, green: g, blue: b)
    }
}

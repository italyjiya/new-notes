//
//  Color+AppStyle.swift
//  new notes
//
//  Created by Monika Suresh Ilamkar on 14/11/25.
//

import SwiftUI

extension Color {
    // If you have a color asset named "AppPink", use:
    // static let appPink = Color("AppPink")

    // Otherwise, define a fallback pink color here:
    static let appPink = Color(red: 0.98, green: 0.36, blue: 0.58) // tweak as desired
}

extension ShapeStyle where Self == Color {
    // Explicitly reference Color.appPink to avoid any self-recursion/ambiguity
    static var appPink: Color { Color.appPink }
}

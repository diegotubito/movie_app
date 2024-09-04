//
//  Font+Extension.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

extension Font {
    struct Roboto {
        static func regular(size: CGFloat) -> Font {
            return Font.custom("Roboto-Regular", size: size)
        }
        
        static func medium(size: CGFloat) -> Font {
            return Font.custom("Roboto-Medium", size: size)
        }
        
        static func bold(size: CGFloat) -> Font {
            return Font.custom("Roboto-Bold", size: size)
        }
    }
}

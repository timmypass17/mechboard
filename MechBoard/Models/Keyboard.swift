//
//  Keyboard.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 10/12/22.
//

import Foundation

enum KeyboardSize: String, CaseIterable, Identifiable {
    case full_sized, compact_full_sized, tenkeyless, compact_tenkeyless, compact, mini
    var id: Self { self }
}

struct Keyboard {
    var size: KeyboardSize = KeyboardSize.full_sized
    var keycaps: String = ""
    var switches: String = ""
    var `case`: String = ""
    var plate: String = ""
    var foam: String = ""
}

extension Keyboard {
    static let sampleKeyboards = [
        Keyboard(
            size: KeyboardSize.compact,
            keycaps: "Osumme Sakura PBT",
            switches: "Gateron Oil King",
            case: "QK65",
            plate: "QK65 FR4 Plate"
        )
    ]
}

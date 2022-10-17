import Foundation

// MARK: - Welcome

struct Casts: Decodable {
    let id: Int
    let cast: [Cast]
}

// MARK: - Cast

struct Cast: Decodable, Hashable {
    let id: Int
    let name: String
    let profile_path: String?
}

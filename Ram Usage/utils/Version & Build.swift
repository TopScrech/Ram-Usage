import Foundation

extension Bundle {
    static var versionAndBuild: String {
        "v\(String(describing: Bundle.version)) (B\(String(describing: Bundle.build))"
    }
}

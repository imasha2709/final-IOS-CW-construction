
import Foundation

enum WorkerStatus: String, CaseIterable {
    case present = "Present"
    case late = "Late"
    case absent = "Absent"
}

struct Worker: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let site: String
    let status: WorkerStatus
    let initials: String
}

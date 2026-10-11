
import Foundation
import Combine

final class AttendanceViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedStatus = "All"

    let records = SampleData.attendance

    let statusOptions = ["All", "Present", "Late", "Absent"]

    var filteredRecords: [AttendanceRecord] {
        records.filter { record in
            let matchesSearch =
                searchText.isEmpty ||
                record.workerName.localizedCaseInsensitiveContains(searchText) ||
                record.site.localizedCaseInsensitiveContains(searchText)

            let matchesStatus =
                selectedStatus == "All" ||
                record.status.rawValue == selectedStatus

            return matchesSearch && matchesStatus
        }
    }

    func count(for status: WorkerStatus) -> Int {
        records.filter { $0.status == status }.count
    }
}

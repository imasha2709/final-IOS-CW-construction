import Foundation
import SwiftUI
import MapKit

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var workers = SampleData.workers
    @Published var projects = SampleData.projects
    @Published var attendance = SampleData.attendance

    var totalWorkers: Int {
        workers.count
    }

    var presentCount: Int {
        workers.filter { $0.status == .present }.count
    }

    var lateCount: Int {
        workers.filter { $0.status == .late }.count
    }

    var activeProjects: Int {
        projects.count
    }
}

@MainActor
final class WorkersViewModel: ObservableObject {
    @Published var workers = SampleData.workers
    @Published var searchText = ""
    @Published var selectedStatus: AttendanceStatus? = nil

    var filteredWorkers: [Worker] {
        workers.filter { worker in
            let matchesSearch =
                searchText.isEmpty ||
                worker.name.localizedCaseInsensitiveContains(searchText) ||
                worker.role.localizedCaseInsensitiveContains(searchText) ||
                worker.site.localizedCaseInsensitiveContains(searchText)

            let matchesStatus =
                selectedStatus == nil ||
                worker.status == selectedStatus

            return matchesSearch && matchesStatus
        }
    }
}

@MainActor
final class AttendanceViewModel: ObservableObject {
    @Published var records = SampleData.attendance
    @Published var selectedFilter: AttendanceStatus? = nil

    var filteredRecords: [AttendanceRecord] {
        guard let selectedFilter else {
            return records
        }

        return records.filter {
            $0.status == selectedFilter
        }
    }

    var presentCount: Int {
        records.filter { $0.status == .present }.count
    }

    var lateCount: Int {
        records.filter { $0.status == .late }.count
    }

    var absentCount: Int {
        records.filter { $0.status == .absent }.count
    }
}

@MainActor
final class ProjectsViewModel: ObservableObject {
    @Published var projects = SampleData.projects
}

@MainActor
final class SiteMapViewModel: ObservableObject {
    @Published var selectedProjectID: UUID? =
        SampleData.projects.first?.id

    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 6.9271,
                longitude: 79.8612
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.16,
                longitudeDelta: 0.16
            )
        )
    )

    var projects: [ConstructionProject] {
        SampleData.projects
    }

    var selectedProject: ConstructionProject? {
        projects.first {
            $0.id == selectedProjectID
        }
    }

    func select(_ project: ConstructionProject) {
        selectedProjectID = project.id

        cameraPosition = .region(
            MKCoordinateRegion(
                center: project.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.035,
                    longitudeDelta: 0.035
                )
            )
        )
    }
}
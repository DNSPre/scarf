import SwiftUI

struct HealthView: View {
    @State private var viewModel = HealthViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection
                if !viewModel.statusSections.isEmpty {
                    sectionGroup("Status", sections: viewModel.statusSections)
                }
                if !viewModel.doctorSections.isEmpty {
                    sectionGroup("Diagnostics", sections: viewModel.doctorSections)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .navigationTitle("Health")
        .onAppear { viewModel.load() }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 16) {
                if !viewModel.version.isEmpty {
                    Text(viewModel.version)
                        .font(.system(.body, design: .monospaced))
                }
                Spacer()
                Button("Refresh") { viewModel.load() }
                    .controlSize(.small)
            }

            if viewModel.hasUpdate {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .foregroundStyle(.orange)
                    Text(viewModel.updateInfo)
                        .font(.caption)
                    Text("Run `hermes update` in terminal")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.orange.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }

            HStack(spacing: 16) {
                CountBadge(count: viewModel.okCount, label: "Passing", color: .green, icon: "checkmark.circle.fill")
                CountBadge(count: viewModel.warningCount, label: "Warnings", color: .orange, icon: "exclamationmark.triangle.fill")
                CountBadge(count: viewModel.issueCount, label: "Issues", color: .red, icon: "xmark.circle.fill")
            }
        }
    }

    private func sectionGroup(_ title: String, sections: [HealthSection]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title3.bold())
            ForEach(sections) { section in
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Image(systemName: section.icon)
                            .foregroundStyle(.secondary)
                            .frame(width: 16)
                        Text(section.title)
                            .font(.headline)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(section.checks) { check in
                            CheckRow(check: check)
                        }
                    }
                    .padding(.leading, 22)
                }
                .padding(12)
                .background(.quaternary.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

struct CheckRow: View {
    let check: HealthCheck

    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            Image(systemName: statusIcon)
                .foregroundStyle(statusColor)
                .font(.caption)
                .frame(width: 14)
            VStack(alignment: .leading, spacing: 1) {
                Text(check.label)
                    .font(.caption)
                if let detail = check.detail {
                    Text(detail)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 1)
    }

    private var statusIcon: String {
        switch check.status {
        case .ok: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "xmark.circle.fill"
        }
    }

    private var statusColor: Color {
        switch check.status {
        case .ok: return .green
        case .warning: return .orange
        case .error: return .red
        }
    }
}

struct CountBadge: View {
    let count: Int
    let label: String
    let color: Color
    let icon: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text("\(count)")
                .font(.system(.title3, design: .monospaced, weight: .semibold))
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.quaternary.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

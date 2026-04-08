import SwiftUI

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(HermesFileWatcher.self) private var fileWatcher

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                statusSection
                statsSection
                recentSessionsSection
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .navigationTitle(L.dashboard)
        .task { await viewModel.load() }
        .onChange(of: fileWatcher.lastChangeDate) {
            Task { await viewModel.load() }
        }
    }

    private var statusSection: some View {
        HStack(spacing: 16) {
            StatusCard(
                title: L.hermes,
                value: viewModel.hermesRunning ? L.running : L.stopped,
                icon: "circle.fill",
                color: viewModel.hermesRunning ? .green : .secondary
            )
            StatusCard(
                title: L.model,
                value: viewModel.config.model,
                icon: "cpu",
                color: .blue
            )
            StatusCard(
                title: L.provider,
                value: viewModel.config.provider,
                icon: "cloud",
                color: .purple
            )
            StatusCard(
                title: L.gateway,
                value: viewModel.gatewayState?.statusText ?? L.unknown,
                icon: "network",
                color: viewModel.gatewayState?.isRunning == true ? .green : .secondary
            )
        }
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(L.usageStats)
                .font(.headline)
            HStack(spacing: 16) {
                StatCard(label: L.sessions, value: "\(viewModel.stats.totalSessions)")
                StatCard(label: L.messages, value: "\(viewModel.stats.totalMessages)")
                StatCard(label: L.toolCalls, value: "\(viewModel.stats.totalToolCalls)")
                StatCard(label: L.tokens, value: formatTokens(viewModel.stats.totalInputTokens + viewModel.stats.totalOutputTokens))
                let cost = viewModel.stats.totalActualCostUSD > 0 ? viewModel.stats.totalActualCostUSD : viewModel.stats.totalCostUSD
                if cost > 0 {
                    StatCard(label: L.cost, value: String(format: "$%.2f", cost))
                }
            }
        }
    }

    private var recentSessionsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(L.recentSessions)
                    .font(.headline)
                Spacer()
                Button(L.viewAll) {
                    coordinator.selectedSection = .sessions
                }
                .buttonStyle(.link)
            }
            ForEach(viewModel.recentSessions) { session in
                SessionRow(session: session, preview: viewModel.sessionPreviews[session.id])
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.selectedSessionId = session.id
                        coordinator.selectedSection = .sessions
                    }
            }
            if viewModel.recentSessions.isEmpty && !viewModel.isLoading {
                Text(L.noSessionsFound)
                    .foregroundStyle(.secondary)
            }
        }
    }

}

struct StatusCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.caption)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(value)
                .font(.system(.body, design: .monospaced))
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(.quaternary.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct StatCard: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(.title2, design: .monospaced, weight: .semibold))
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(.quaternary.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct SessionRow: View {
    let session: HermesSession
    var preview: String?

    var body: some View {
        HStack {
            Image(systemName: session.sourceIcon)
                .foregroundStyle(.secondary)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(preview ?? session.displayTitle)
                    .lineLimit(1)
                if let date = session.startedAt {
                    Text(date, style: .relative)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            HStack(spacing: 12) {
                Label("\(session.messageCount)", systemImage: "bubble.left")
                Label("\(session.toolCallCount)", systemImage: "wrench")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

import SwiftUI

struct CronView: View {
    @State private var viewModel = CronViewModel()

    var body: some View {
        HSplitView {
            jobsList
                .frame(minWidth: 300, idealWidth: 350)
            jobDetail
                .frame(minWidth: 400)
        }
        .navigationTitle(L.cronJobs)
        .onAppear { viewModel.load() }
    }

    private var jobsList: some View {
        List(selection: Binding(
            get: { viewModel.selectedJob?.id },
            set: { id in
                if let id, let job = viewModel.jobs.first(where: { $0.id == id }) {
                    viewModel.selectJob(job)
                } else {
                    viewModel.selectedJob = nil
                    viewModel.jobOutput = nil
                }
            }
        )) {
            ForEach(viewModel.jobs) { job in
                HStack {
                    Image(systemName: job.stateIcon)
                        .foregroundStyle(job.enabled ? .primary : .secondary)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(job.name)
                            .lineLimit(1)
                        Text(job.schedule.display ?? job.schedule.kind)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if !job.enabled {
                        Text(L.disabled)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                .tag(job.id)
            }
        }
        .listStyle(.inset)
        .overlay {
            if viewModel.jobs.isEmpty {
                ContentUnavailableView(L.noCronJobs, systemImage: "clock.arrow.2.circlepath", description: Text(L.noScheduledJobsConfigured))
            }
        }
    }

    @ViewBuilder
    private var jobDetail: some View {
        if let job = viewModel.selectedJob {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(job.name)
                            .font(.title2.bold())
                        HStack(spacing: 16) {
                            Label(job.state, systemImage: job.stateIcon)
                            Label(job.schedule.display ?? job.schedule.kind, systemImage: "clock")
                            Label(job.enabled ? L.enabled : L.disabled, systemImage: job.enabled ? "checkmark.circle" : "xmark.circle")
                            if let deliver = job.deliver {
                                Label("\(L.deliver) \(deliver)", systemImage: "paperplane")
                            }
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 4) {
                        Text(L.prompt)
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                        Text(job.prompt)
                            .textSelection(.enabled)
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.quaternary.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    if let skills = job.skills, !skills.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(L.skills)
                                .font(.caption.bold())
                                .foregroundStyle(.secondary)
                            HStack {
                                ForEach(skills, id: \.self) { skill in
                                    Text(skill)
                                        .font(.caption.monospaced())
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(.quaternary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    if let nextRun = job.nextRunAt {
                        Label("\(L.nextRun) \(nextRun)", systemImage: "arrow.forward.circle")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    if let lastRun = job.lastRunAt {
                        Label("\(L.lastRun) \(lastRun)", systemImage: "arrow.backward.circle")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    if let error = job.lastError {
                        Label(error, systemImage: "exclamationmark.triangle")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    if let output = viewModel.jobOutput {
                        Divider()
                        VStack(alignment: .leading, spacing: 4) {
                            Text(L.lastOutput)
                                .font(.caption.bold())
                                .foregroundStyle(.secondary)
                            Text(output)
                                .font(.system(.caption, design: .monospaced))
                                .textSelection(.enabled)
                                .padding(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.quaternary.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        } else {
            ContentUnavailableView(L.selectJob, systemImage: "clock.arrow.2.circlepath", description: Text(L.chooseCronJobFromList))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

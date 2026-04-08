import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @State private var showRawConfig = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerBar
                modelSection
                displaySection
                terminalSection
                voiceSection
                memorySection
                pathsSection
                rawConfigSection
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .navigationTitle(L.settings)
        .onAppear { viewModel.load() }
    }

    private var headerBar: some View {
        HStack {
            if let msg = viewModel.saveMessage {
                Label(msg, systemImage: "checkmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.green)
            }
            Spacer()
            Button(L.openInEditor) { viewModel.openConfigInEditor() }
                .controlSize(.small)
            Button(L.reload) { viewModel.load() }
                .controlSize(.small)
        }
    }

    // MARK: - Model & Provider

    private var modelSection: some View {
        SettingsSection(title: L.model, icon: "cpu") {
            EditableTextField(label: L.model, value: viewModel.config.model) { viewModel.setModel($0) }
            PickerRow(label: L.provider, selection: viewModel.config.provider, options: viewModel.providers) { viewModel.setProvider($0) }
        }
    }

    // MARK: - Display

    private var displaySection: some View {
        SettingsSection(title: L.display, icon: "paintbrush") {
            if !viewModel.personalities.isEmpty {
                PickerRow(label: L.personality, selection: viewModel.config.personality, options: viewModel.personalities) { viewModel.setPersonality($0) }
            } else {
                EditableTextField(label: L.personality, value: viewModel.config.personality) { viewModel.setPersonality($0) }
            }
            ToggleRow(label: L.streaming, isOn: viewModel.config.streaming) { viewModel.setStreaming($0) }
            ToggleRow(label: L.showReasoning, isOn: viewModel.config.showReasoning) { viewModel.setShowReasoning($0) }
            ToggleRow(label: L.showCost, isOn: viewModel.config.showCost) { viewModel.setShowCost($0) }
            ToggleRow(label: L.verbose, isOn: viewModel.config.verbose) { viewModel.setVerbose($0) }
        }
    }

    // MARK: - Terminal

    private var terminalSection: some View {
        SettingsSection(title: L.terminal, icon: "terminal") {
            PickerRow(label: L.backend, selection: viewModel.config.terminalBackend, options: viewModel.terminalBackends) { viewModel.setTerminalBackend($0) }
            StepperRow(label: L.maxTurns, value: viewModel.config.maxTurns, range: 1...200) { viewModel.setMaxTurns($0) }
            PickerRow(label: L.reasoningEffort, selection: viewModel.config.reasoningEffort, options: [L.string("low"), L.string("medium"), L.string("high")]) { viewModel.setReasoningEffort($0) }
            PickerRow(label: L.approvalMode, selection: viewModel.config.approvalMode, options: [L.string("auto"), L.string("manual"), L.string("smart")]) { viewModel.setApprovalMode($0) }
        }
    }

    // MARK: - Voice

    private var voiceSection: some View {
        SettingsSection(title: L.voice, icon: "mic") {
            ToggleRow(label: L.autoTTS, isOn: viewModel.config.autoTTS) { viewModel.setAutoTTS($0) }
            StepperRow(label: L.silenceThreshold, value: viewModel.config.silenceThreshold, range: 50...500) { viewModel.setSilenceThreshold($0) }
        }
    }

    // MARK: - Memory

    private var memorySection: some View {
        SettingsSection(title: L.memory, icon: "brain") {
            ToggleRow(label: L.memoryEnabled, isOn: viewModel.config.memoryEnabled) { viewModel.setMemoryEnabled($0) }
            StepperRow(label: L.memoryCharLimit, value: viewModel.config.memoryCharLimit, range: 500...10000) { viewModel.setMemoryCharLimit($0) }
            StepperRow(label: L.userCharLimit, value: viewModel.config.userCharLimit, range: 500...10000) { viewModel.setUserCharLimit($0) }
            StepperRow(label: L.nudgeInterval, value: viewModel.config.nudgeInterval, range: 1...50) { viewModel.setNudgeInterval($0) }
        }
    }

    // MARK: - Paths

    private var pathsSection: some View {
        SettingsSection(title: L.paths, icon: "folder") {
            PathRow(label: L.hermesHome, path: HermesPaths.home)
            PathRow(label: L.stateDB, path: HermesPaths.stateDB)
            PathRow(label: L.config, path: HermesPaths.configYAML)
            PathRow(label: L.memory, path: HermesPaths.memoriesDir)
            PathRow(label: L.sessions, path: HermesPaths.sessionsDir)
            PathRow(label: L.skills, path: HermesPaths.skillsDir)
            PathRow(label: L.logs, path: HermesPaths.errorsLog)
        }
    }

    // MARK: - Raw Config

    private var rawConfigSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(L.rawConfig)
                    .font(.headline)
                Button(showRawConfig ? L.hide : L.show) {
                    showRawConfig.toggle()
                }
                .controlSize(.small)
            }
            if showRawConfig {
                Text(viewModel.rawConfigYAML)
                    .font(.system(.caption, design: .monospaced))
                    .textSelection(.enabled)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.quaternary.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
    }
}

// MARK: - Reusable Components

struct SettingsSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: icon)
                .font(.headline)
            VStack(spacing: 1) {
                content
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct EditableTextField: View {
    let label: String
    let value: String
    let onCommit: (String) -> Void
    @State private var text: String = ""
    @State private var isEditing = false

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 130, alignment: .trailing)
            if isEditing {
                TextField(label, text: $text, onCommit: {
                    if text != value { onCommit(text) }
                    isEditing = false
                })
                .textFieldStyle(.roundedBorder)
                .font(.system(.caption, design: .monospaced))
                Button(L.cancel) { isEditing = false }
                    .controlSize(.mini)
            } else {
                Text(value)
                    .font(.system(.caption, design: .monospaced))
                Spacer()
                Button(L.edit) {
                    text = value
                    isEditing = true
                }
                .controlSize(.mini)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.quaternary.opacity(0.3))
    }
}

struct PickerRow: View {
    let label: String
    let selection: String
    let options: [String]
    let onChange: (String) -> Void

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 130, alignment: .trailing)
            Picker("", selection: Binding(
                get: { selection },
                set: { onChange($0) }
            )) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .frame(maxWidth: 250)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.quaternary.opacity(0.3))
    }
}

struct ToggleRow: View {
    let label: String
    let isOn: Bool
    let onChange: (Bool) -> Void

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 130, alignment: .trailing)
            Toggle("", isOn: Binding(
                get: { isOn },
                set: { onChange($0) }
            ))
            .toggleStyle(.switch)
            .labelsHidden()
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.quaternary.opacity(0.3))
    }
}

struct StepperRow: View {
    let label: String
    let value: Int
    let range: ClosedRange<Int>
    let onChange: (Int) -> Void

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 130, alignment: .trailing)
            Text("\(value)")
                .font(.system(.caption, design: .monospaced))
                .frame(width: 50)
            Stepper("", value: Binding(
                get: { value },
                set: { onChange($0) }
            ), in: range)
            .labelsHidden()
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.quaternary.opacity(0.3))
    }
}

struct PathRow: View {
    let label: String
    let path: String

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 130, alignment: .trailing)
            Text(path)
                .font(.system(.caption, design: .monospaced))
                .textSelection(.enabled)
            Spacer()
            Button {
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: path)
            } label: {
                Image(systemName: "folder")
                    .font(.caption)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.quaternary.opacity(0.3))
    }
}

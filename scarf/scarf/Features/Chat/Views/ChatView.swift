import SwiftUI

struct ChatView: View {
    @Environment(ChatViewModel.self) private var viewModel
    @Environment(HermesFileWatcher.self) private var fileWatcher

    var body: some View {
        VStack(spacing: 0) {
            toolbar
            Divider()
            terminalArea
        }
        .navigationTitle(L.chat)
        .task { await viewModel.loadRecentSessions() }
        .onChange(of: fileWatcher.lastChangeDate) {
            Task { await viewModel.loadRecentSessions() }
        }
    }

    private var toolbar: some View {
        HStack(spacing: 12) {
            Image(systemName: "terminal")
                .foregroundStyle(.secondary)

            if viewModel.hasActiveProcess {
                Circle()
                    .fill(.green)
                    .frame(width: 6, height: 6)
                Text(L.active)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Circle()
                    .fill(.secondary)
                    .frame(width: 6, height: 6)
                Text(L.noActiveSession)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if viewModel.hasActiveProcess {
                voiceControls
            }

            if !viewModel.hermesBinaryExists {
                Label(L.hermesBinaryNotFound, systemImage: "exclamationmark.triangle")
                    .font(.caption)
                    .foregroundStyle(.red)
            }

            Menu {
                Button(L.newSession) {
                    viewModel.startNewSession()
                }
                Button(L.continueLastSession) {
                    viewModel.continueLastSession()
                }
                if !viewModel.recentSessions.isEmpty {
                    Divider()
                    Text(L.resumeSession)
                    ForEach(viewModel.recentSessions) { session in
                        Button {
                            viewModel.resumeSession(session.id)
                        } label: {
                            HStack {
                                Text(viewModel.previewFor(session))
                                    .lineLimit(1)
                                if let date = session.startedAt {
                                    Text("·")
                                        .foregroundStyle(.secondary)
                                    Text(date, style: .relative)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            } label: {
                Label(L.session, systemImage: "play.circle")
                    .font(.caption)
            }
            .menuStyle(.borderlessButton)
            .fixedSize()
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }

    private var voiceControls: some View {
        HStack(spacing: 8) {
            Button {
                viewModel.toggleVoice()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: viewModel.voiceEnabled ? "mic.fill" : "mic.slash")
                        .foregroundStyle(viewModel.voiceEnabled ? .green : .secondary)
                    Text(viewModel.voiceEnabled ? L.voiceOn : L.voiceOff)
                        .font(.caption)
                        .foregroundStyle(viewModel.voiceEnabled ? .primary : .secondary)
                }
            }
            .buttonStyle(.plain)
            .help(L.string("Toggle voice mode (/voice)"))

            if viewModel.voiceEnabled {
                Button {
                    viewModel.toggleTTS()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: viewModel.ttsEnabled ? "speaker.wave.2.fill" : "speaker.slash")
                            .foregroundStyle(viewModel.ttsEnabled ? .green : .secondary)
                        Text(viewModel.ttsEnabled ? L.ttsOn : L.ttsOff)
                            .font(.caption)
                            .foregroundStyle(viewModel.ttsEnabled ? .primary : .secondary)
                    }
                }
                .buttonStyle(.plain)
                .help(L.string("Toggle text-to-speech (/voice tts)"))

                Button {
                    viewModel.pushToTalk()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: viewModel.isRecording ? "waveform.circle.fill" : "waveform.circle")
                            .foregroundStyle(viewModel.isRecording ? .red : Color.accentColor)
                            .symbolEffect(.pulse, isActive: viewModel.isRecording)
                        Text(viewModel.isRecording ? L.recording : L.pushToTalk)
                            .font(.caption)
                    }
                }
                .buttonStyle(.plain)
                .help(L.string("Push to talk (Ctrl+B)"))
                .keyboardShortcut("b", modifiers: .control)
            }
        }
    }

    @ViewBuilder
    private var terminalArea: some View {
        if let terminal = viewModel.terminalView {
            PersistentTerminalView(terminalView: terminal)
        } else if viewModel.hermesBinaryExists {
            ContentUnavailableView(
                L.string("No Active Session"),
                systemImage: "terminal",
                description: Text(L.noActiveSessionHint)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ContentUnavailableView(
                L.hermesNotFound,
                systemImage: "terminal",
                description: Text("Expected at \(HermesPaths.hermesBinary)")
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

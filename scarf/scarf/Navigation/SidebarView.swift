import SwiftUI

struct SidebarView: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        @Bindable var coordinator = coordinator
        List(selection: $coordinator.selectedSection) {
            Section(L.monitor) {
                ForEach([SidebarSection.dashboard, .insights, .sessions, .activity]) { section in
                    Label(section.localized, systemImage: section.icon)
                        .tag(section)
                }
            }
            Section(L.projects) {
                ForEach([SidebarSection.projects]) { section in
                    Label(section.localized, systemImage: section.icon)
                        .tag(section)
                }
            }
            Section(L.interact) {
                ForEach([SidebarSection.chat, .memory, .skills]) { section in
                    Label(section.localized, systemImage: section.icon)
                        .tag(section)
                }
            }
            Section(L.manage) {
                ForEach([SidebarSection.tools, .gateway, .cron, .health, .logs, .settings]) { section in
                    Label(section.localized, systemImage: section.icon)
                        .tag(section)
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle(L.appName)
    }
}

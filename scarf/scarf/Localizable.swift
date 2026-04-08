import Foundation

/// 本地化字符串访问助手
/// 自动读取 Localizable.strings 中的翻译
enum L {
    /// 根据 key 返回本地化字符串
    /// - Parameter key: 字符串 key（与 Localizable.strings 中的 key 对应）
    /// - Returns: 翻译后的字符串，系统语言不是中文时回退到英文
    static func string(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    // =============================================
    // MARK: - 侧边栏 & 导航
    // =============================================
    static var appName: String { string("Scarf") }
    static var monitor: String { string("Monitor") }
    static var projects: String { string("Projects") }
    static var interact: String { string("Interact") }
    static var manage: String { string("Manage") }
    static var dashboard: String { string("Dashboard") }
    static var insights: String { string("Insights") }
    static var sessions: String { string("Sessions") }
    static var activity: String { string("Activity") }
    static var chat: String { string("Chat") }
    static var memory: String { string("Memory") }
    static var skills: String { string("Skills") }
    static var tools: String { string("Tools") }
    static var gateway: String { string("Gateway") }
    static var cron: String { string("Cron") }
    static var health: String { string("Health") }
    static var logs: String { string("Logs") }
    static var settings: String { string("Settings") }

    // =============================================
    // MARK: - Dashboard
    // =============================================
    static var hermes: String { string("Hermes") }
    static var running: String { string("Running") }
    static var stopped: String { string("Stopped") }
    static var model: String { string("Model") }
    static var provider: String { string("Provider") }
    static var unknown: String { string("unknown") }
    static var usageStats: String { string("Usage Stats") }
    static var messages: String { string("Messages") }
    static var toolCalls: String { string("Tool Calls") }
    static var tokens: String { string("Tokens") }
    static var cost: String { string("Cost") }
    static var recentSessions: String { string("Recent Sessions") }
    static var viewAll: String { string("View All") }
    static var noSessionsFound: String { string("No sessions found") }

    // =============================================
    // MARK: - Sessions
    // =============================================
    static var searchMessages: String { string("Search messages...") }
    static var exportAll: String { string("Export All") }
    static var searchResults: String { string("Search Results (") }
    static var selectSession: String { string("Select a Session") }
    static var chooseSessionFromList: String { string("Choose a session from the list") }
    static var rename: String { string("Rename...") }
    static var export: String { string("Export...") }
    static var delete: String { string("Delete...") }
    static var deleteSessionQuestion: String { string("Delete Session?") }
    static var deleteSessionMessage: String { string("This will permanently delete the session and all its messages.") }
    static var renameSession: String { string("Rename Session") }
    static var sessionTitle: String { string("Session title") }

    // =============================================
    // MARK: - Chat
    // =============================================
    static var active: String { string("Active") }
    static var noActiveSession: String { string("No active session") }
    static var hermesBinaryNotFound: String { string("Hermes binary not found") }
    static var session: String { string("Session") }
    static var newSession: String { string("New Session") }
    static var continueLastSession: String { string("Continue Last Session") }
    static var resumeSession: String { string("Resume Session") }
    static var voiceOn: String { string("Voice On") }
    static var voiceOff: String { string("Voice Off") }
    static var ttsOn: String { string("TTS On") }
    static var ttsOff: String { string("TTS Off") }
    static var recording: String { string("Recording...") }
    static var pushToTalk: String { string("Push to Talk") }
    static var noActiveSessionHint: String { string("Start a new session or resume an existing one from the Session menu above.") }
    static var hermesNotFound: String { string("Hermes Not Found") }

    // =============================================
    // MARK: - Activity
    // =============================================
    static var all: String { string("All") }
    static var allSessions: String { string("All Sessions") }
    static var openSession: String { string("Open session") }
    static var selectToolCall: String { string("Select a Tool Call") }
    static var chooseEntryFromList: String { string("Choose an entry from the list") }
    static var noActivity: String { string("No Activity") }
    static var noToolCallsFound: String { string("No tool calls found") }
    static var arguments: String { string("Arguments") }
    static var assistantMessage: String { string("Assistant Message") }

    // =============================================
    // MARK: - Cron
    // =============================================
    static var cronJobs: String { string("Cron Jobs") }
    static var noCronJobs: String { string("No Cron Jobs") }
    static var noScheduledJobsConfigured: String { string("No scheduled jobs configured") }
    static var enabled: String { string("Enabled") }
    static var disabled: String { string("Disabled") }
    static var prompt: String { string("Prompt") }
    static var nextRun: String { string("Next run:") }
    static var lastRun: String { string("Last run:") }
    static var lastOutput: String { string("Last Output") }
    static var selectJob: String { string("Select a Job") }
    static var chooseCronJobFromList: String { string("Choose a cron job from the list") }
    static var deliver: String { string("Deliver:") }

    // =============================================
    // MARK: - Gateway
    // =============================================
    static var service: String { string("Service") }
    static var start: String { string("Start") }
    static var stop: String { string("Stop") }
    static var restart: String { string("Restart") }
    static var loaded: String { string("Loaded") }
    static var serviceDefinitionStale: String { string("Service definition stale") }
    static var lastUpdated: String { string("Last updated:") }
    static var platforms: String { string("Platforms") }
    static var noPlatformsConnected: String { string("No platforms connected") }
    static var pairedUsers: String { string("Paired Users") }
    static var pendingApprovals: String { string("Pending Approvals") }
    static var code: String { string("Code:") }
    static var approve: String { string("Approve") }
    static var noPairedUsers: String { string("No paired users") }
    static var revoke: String { string("Revoke") }

    // =============================================
    // MARK: - Memory
    // =============================================
    static var agentMemory: String { string("Agent Memory") }
    static var userProfile: String { string("User Profile") }
    static var empty: String { string("Empty") }
    static var edit: String { string("Edit") }
    static var save: String { string("Save") }
    static var editAgentMemory: String { string("Edit Agent Memory") }
    static var editUserProfile: String { string("Edit User Profile") }

    // =============================================
    // MARK: - Skills
    // =============================================
    static var filterSkills: String { string("Filter skills...") }
    static var files: String { string("Files") }
    static var selectSkill: String { string("Select a Skill") }
    static var chooseSkillFromList: String { string("Choose a skill from the list") }

    // =============================================
    // MARK: - Projects
    // =============================================
    static var site: String { string("Site") }
    static var updated: String { string("Updated:") }
    static var noDashboard: String { string("No Dashboard") }
    static var noProjects: String { string("No Projects") }
    static var selectProject: String { string("Select a Project") }
    static var addProject: String { string("Add Project") }
    static var browse: String { string("Browse...") }
    static var projectName: String { string("Project Name") }
    static var projectPath: String { string("Project Path") }

    // =============================================
    // MARK: - Health
    // =============================================
    static var status: String { string("Status") }
    static var diagnostics: String { string("Diagnostics") }
    static var refresh: String { string("Refresh") }

    // =============================================
    // MARK: - Logs
    // =============================================
    static var filterLogs: String { string("Filter logs...") }
    static var allLevels: String { string("All Levels") }

    // =============================================
    // MARK: - Insights
    // =============================================
    static var period: String { string("Period") }
    static var overview: String { string("Overview") }
    static var models: String { string("Models") }
    static var noData: String { string("No data") }
    static var topTools: String { string("Top Tools") }
    static var activityPatterns: String { string("Activity Patterns") }
    static var byDay: String { string("By Day") }
    static var byHour: String { string("By Hour") }
    static var notableSessions: String { string("Notable Sessions") }
    static var userMessages: String { string("User Messages") }
    static var inputTokens: String { string("Input Tokens") }
    static var outputTokens: String { string("Output Tokens") }
    static var cacheRead: String { string("Cache Read") }
    static var cacheWrite: String { string("Cache Write") }
    static var reasoningTokens: String { string("Reasoning Tokens") }
    static var totalTokens: String { string("Total Tokens") }
    static var totalCost: String { string("Total Cost") }
    static var activeTime: String { string("Active Time") }
    static var avgSession: String { string("Avg Session") }
    static var avgMsgsPerSession: String { string("Avg Msgs/Session") }

    // =============================================
    // MARK: - Tools
    // =============================================
    static var mcpServers: String { string("MCP Servers") }
    static var noMcpServersConfigured: String { string("No MCP servers configured") }

    // =============================================
    // MARK: - Settings
    // =============================================
    static var openInEditor: String { string("Open in Editor") }
    static var reload: String { string("Reload") }
    static var modelAndProvider: String { string("Model & Provider") }
    static var display: String { string("Display") }
    static var personality: String { string("Personality") }
    static var streaming: String { string("Streaming") }
    static var showReasoning: String { string("Show Reasoning") }
    static var showCost: String { string("Show Cost") }
    static var verbose: String { string("Verbose") }
    static var backend: String { string("Backend") }
    static var terminal: String { string("Terminal") }
    static var maxTurns: String { string("Max Turns") }
    static var reasoningEffort: String { string("Reasoning Effort") }
    static var approvalMode: String { string("Approval Mode") }
    static var autoTTS: String { string("Auto TTS") }
    static var silenceThreshold: String { string("Silence Threshold") }
    static var memoryEnabled: String { string("Memory Enabled") }
    static var memoryCharLimit: String { string("Memory Char Limit") }
    static var userCharLimit: String { string("User Char Limit") }
    static var nudgeInterval: String { string("Nudge Interval") }
    static var paths: String { string("Paths") }
    static var hermesHome: String { string("Hermes Home") }
    static var stateDB: String { string("State DB") }
    static var config: String { string("Config") }
    static var rawConfig: String { string("Raw Config") }
    static var show: String { string("Show") }
    static var hide: String { string("Hide") }
    static var voice: String { string("Voice") }

    // =============================================
    // MARK: - Common
    // =============================================
    static var cancel: String { string("Cancel") }
    static var add: String { string("Add") }
    static var reasoning: String { string("Reasoning") }
}

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var username: String
    var displayName: String
    var bio: String
    var isAnonymous: Bool
    var joinedDate: Date
    var topics: [String]
    var postCount: Int
    var helpfulCount: Int

    init(id: UUID = UUID(), username: String = "", displayName: String = "Anonym", bio: String = "", isAnonymous: Bool = true, joinedDate: Date = Date(), topics: [String] = [], postCount: Int = 0, helpfulCount: Int = 0) {
        self.id = id
        self.username = username
        self.displayName = displayName
        self.bio = bio
        self.isAnonymous = isAnonymous
        self.joinedDate = joinedDate
        self.topics = topics
        self.postCount = postCount
        self.helpfulCount = helpfulCount
    }
}

struct ForumPost: Identifiable, Codable {
    let id: UUID
    var authorId: UUID
    var authorName: String
    var title: String
    var content: String
    var category: PostCategory
    var createdAt: Date
    var replies: [Reply]
    var likes: Int
    var isPinned: Bool

    init(id: UUID = UUID(), authorId: UUID, authorName: String, title: String, content: String, category: PostCategory, createdAt: Date = Date(), replies: [Reply] = [], likes: Int = 0, isPinned: Bool = false) {
        self.id = id
        self.authorId = authorId
        self.authorName = authorName
        self.title = title
        self.content = content
        self.category = category
        self.createdAt = createdAt
        self.replies = replies
        self.likes = likes
        self.isPinned = isPinned
    }
}

struct Reply: Identifiable, Codable {
    let id: UUID
    var authorId: UUID
    var authorName: String
    var content: String
    var createdAt: Date
    var likes: Int

    init(id: UUID = UUID(), authorId: UUID, authorName: String, content: String, createdAt: Date = Date(), likes: Int = 0) {
        self.id = id
        self.authorId = authorId
        self.authorName = authorName
        self.content = content
        self.createdAt = createdAt
        self.likes = likes
    }
}

enum PostCategory: String, Codable, CaseIterable {
    case anxiety = "Ångest"
    case depression = "Depression"
    case stress = "Stress"
    case burnout = "Utbrändhet"
    case relationships = "Relationer"
    case selfharm = "Självskada"
    case grief = "Sorg"
    case general = "Allmänt"
    case tips = "Tips & Råd"
    case crisis = "Krishjälp"

    var icon: String {
        switch self {
        case .anxiety: return "brain.head.profile"
        case .depression: return "cloud.rain"
        case .stress: return "bolt"
        case .burnout: return "flame"
        case .relationships: return "person.2"
        case .selfharm: return "heart.slash"
        case .grief: return "leaf"
        case .general: return "bubble.left.and.bubble.right"
        case .tips: return "lightbulb"
        case .crisis: return "phone.badge.plus"
        }
    }

    var color: String {
        switch self {
        case .anxiety: return "#8B5CF6"
        case .depression: return "#64748B"
        case .stress: return "#F59E0B"
        case .burnout: return "#EF4444"
        case .relationships: return "#EC4899"
        case .selfharm: return "#DC2626"
        case .grief: return "#84CC16"
        case .general: return "#06B6D4"
        case .tips: return "#22C55E"
        case .crisis: return "#DC2626"
        }
    }
}

struct KnowledgeArticle: Identifiable, Codable {
    let id: UUID
    var title: String
    var summary: String
    var content: String
    var category: PostCategory
    var source: String
    var tags: [String]
    var createdAt: Date
    var helpfulCount: Int

    init(id: UUID = UUID(), title: String, summary: String, content: String, category: PostCategory, source: String = "Forum-sammanfattning", tags: [String] = [], createdAt: Date = Date(), helpfulCount: Int = 0) {
        self.id = id
        self.title = title
        self.summary = summary
        self.content = content
        self.category = category
        self.source = source
        self.tags = tags
        self.createdAt = createdAt
        self.helpfulCount = helpfulCount
    }
}

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var mood: MoodLevel
    var note: String

    init(id: UUID = UUID(), date: Date = Date(), mood: MoodLevel, note: String = "") {
        self.id = id
        self.date = date
        self.mood = mood
        self.note = note
    }
}

enum MoodLevel: Int, Codable, CaseIterable {
    case veryBad = 1
    case bad = 2
    case okay = 3
    case good = 4
    case veryGood = 5

    var emoji: String {
        switch self {
        case .veryBad: return "😢"
        case .bad: return "😔"
        case .okay: return "😐"
        case .good: return "🙂"
        case .veryGood: return "😊"
        }
    }

    var label: String {
        switch self {
        case .veryBad: return "Mycket dåligt"
        case .bad: return "Dåligt"
        case .okay: return "Okej"
        case .good: return "Bra"
        case .veryGood: return "Mycket bra"
        }
    }
}
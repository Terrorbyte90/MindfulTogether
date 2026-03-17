import Foundation

class DataManager {
    static let shared = DataManager()
    
    var currentUser = User(id: UUID(), username: "användare123", displayName: "Anonym", bio: "Jag är här för att lyssna och dela", isAnonymous: false, topics: ["ångest", "stress"])
    
    var recentPosts: [ForumPost] {
        allPosts.sorted { $0.createdAt > $1.createdAt }.prefix(5).map { $0 }
    }
    
    var allPosts: [ForumPost] = [
        ForumPost(id: UUID(), authorId: UUID(), authorName: "Lina", title: "Hur hanterar man återkommande panikattacker?", content: "Jag har haft panikattacker i några månader nu. Det kom plötsligt och jag vet inte vad som utlöser det. Någon som har tips?", category: .anxiety, createdAt: Date().addingTimeInterval(-3600), likes: 12),
        ForumPost(id: UUID(), authorId: UUID(), authorName: "Mikael", title: "Min första terapi - vad förväntade jag mig?", content: "Idag hade jag min första terapi. Jag var nervös men det gick faktiskt bra. Terapeuten var väldigt förstående.", category: .general, createdAt: Date().addingTimeInterval(-7200), likes: 8),
        ForumPost(id: UUID(), authorId: UUID(), authorName: "Sara", title: "Tips: Sömn hjälpte mig mest", content: "Efter år av sömnproblem upptäckte jag att regelbundna sovtider gjorde stor skillnad. Här är mina tips...", category: .tips, createdAt: Date().addingTimeInterval(-10800), likes: 24),
        ForumPost(id: UUID(), authorId: UUID(), authorName: "Alex", title: "Känner mig ensam trots att jag har vänner", content: "Ibland känns det som att ingen förstår mig. Har någon annan upplevt detta?", category: .depression, createdAt: Date().addingTimeInterval(-14400), likes: 15),
        ForumPost(id: UUID(), authorId: UUID(), authorName: "Emma", title: "Utbränd - min resa hittills", content: "Efter att ha jobbat 60+ timmar i veckan i 2 år kollapsade jag. Vill dela min erfarenhet för att hjälpa andra.", category: .burnout, createdAt: Date().addingTimeInterval(-18000), likes: 31)
    ]
    
    var moodEntries: [MoodEntry] = [
        MoodEntry(date: Date().addingTimeInterval(-86400), mood: .good, note: "Bättre idag"),
        MoodEntry(date: Date().addingTimeInterval(-172800), mood: .okay, note: "Vanlig dag"),
        MoodEntry(date: Date().addingTimeInterval(-259200), mood: .bad, note: "Kände mig lite nere")
    ]

    var knowledgeArticles: [KnowledgeArticle] = [
        KnowledgeArticle(id: UUID(), title: "Vad är ångest?", summary: "Ångest är en naturlig reaktion men kan bli överväldigande.", content: "Ångest är kroppens sätt att reagera på hot eller fara. Det är helt normalt att känna ångest ibland, men när det börjar påverka vardagen kan det vara läge att söka hjälp.", category: .anxiety, tags: ["ångest", "psykisk hälsa"]),
        KnowledgeArticle(id: UUID(), title: "Grundläggande om depression", summary: "Depression är mer än bara sorgsenhet.", content: "Depression är en diagnosbar sjukdom som påverkar hur du känner, tänker och handlar. Det är viktigt att söka professionell hjälp.", category: .depression, tags: ["depression", "psykisk hälsa"]),
        KnowledgeArticle(id: UUID(), title: "Självvård för nybörjare", summary: "Små steg som gör stor skillnad.", content: "Självvård handlar inte om att vara egoistisk utan om att ta hand om sig själv. Börja med små saker: sova tillräckligt, ät regelbundet, ta pauser.", category: .tips, tags: ["självvård", "välmående"])
    ]
    
    private init() {}
    
    func addPost(_ post: ForumPost) {
        allPosts.insert(post, at: 0)
    }
    
    func getArticles(for category: PostCategory? = nil) -> [KnowledgeArticle] {
        if let cat = category {
            return knowledgeArticles.filter { $0.category == cat }
        }
        return knowledgeArticles
    }
}

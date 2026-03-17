import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Hem", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        let communityVC = CommunityViewController()
        let communityNav = UINavigationController(rootViewController: communityVC)
        communityNav.tabBarItem = UITabBarItem(title: "Community", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))

        let knowledgeVC = KnowledgeViewController()
        let knowledgeNav = UINavigationController(rootViewController: knowledgeVC)
        knowledgeNav.tabBarItem = UITabBarItem(title: "Kunskap", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book.fill"))

        let moodVC = MoodViewController()
        let moodNav = UINavigationController(rootViewController: moodVC)
        moodNav.tabBarItem = UITabBarItem(title: "Mående", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))

        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profil", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))

        viewControllers = [homeNav, communityNav, knowledgeNav, moodNav, profileNav]
    }
}
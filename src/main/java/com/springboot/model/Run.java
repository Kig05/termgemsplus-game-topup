package com.springboot.model;

import com.springboot.repository.GameRepository;
import com.springboot.repository.GamePackageRepository;
import com.springboot.repository.TopUpOrderRepository;
import com.springboot.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class Run implements CommandLineRunner {

    private final UserRepository userRepository;
    private final GameRepository gameRepository;
    private final GamePackageRepository packageRepository;
    private final TopUpOrderRepository topUpOrderRepository;

    public Run(UserRepository userRepository, GameRepository gameRepository, 
                          GamePackageRepository packageRepository, TopUpOrderRepository topUpOrderRepository) {
        this.userRepository = userRepository;
        this.gameRepository = gameRepository;
        this.packageRepository = packageRepository;
        this.topUpOrderRepository = topUpOrderRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        // Check if data already exists
        if (userRepository.count() > 0) {
            System.out.println("Database already contains data. Skipping initialization.");
            System.out.println("✅ Dummy data initialized already!");
            System.out.println("   - Users: " + userRepository.count());
            System.out.println("   - Games: " + gameRepository.count());
            System.out.println("   - Packages: " + packageRepository.count());
            System.out.println("   - Orders: " + topUpOrderRepository.count());
            System.out.println("\n📌 Test Login Credentials:");
            System.out.println("   Admin - username: admin, password: admin123");
            System.out.println("   User  - username: user, password: user123");
            return;
        }

        System.out.println("Initializing dummy data...");

        // Create Admin User
        User admin = new User();
        admin.setUsername("admin");
        admin.setPassword("admin123"); // In production, use encrypted passwords
        admin.setEmail("admin@gametopup.com");
        admin.setFullName("System Administrator");
        admin.setPhoneNumber("0812345678");
        admin.setRole("admin");
        admin.setBalance(0.0);
        admin.setActive(true);
        userRepository.save(admin);

        // Create Users
        User user1 = new User();
        user1.setUsername("user");
        user1.setPassword("user123");
        user1.setEmail("john@example.com");
        user1.setFullName("John Smith");
        user1.setPhoneNumber("0823456789");
        user1.setRole("user");
        user1.setBalance(0.0);
        user1.setActive(true);
        userRepository.save(user1);

        User user2 = new User();
        user2.setUsername("sarah_player");
        user2.setPassword("user123");
        user2.setEmail("sarah@example.com");
        user2.setFullName("Sarah Johnson");
        user2.setPhoneNumber("0834567890");
        user2.setRole("user");
        user2.setBalance(100.0);
        user2.setActive(true);
        userRepository.save(user2);

        User user3 = new User();
        user3.setUsername("mike_pro");
        user3.setPassword("user123");
        user3.setEmail("mike@example.com");
        user3.setFullName("Mike Williams");
        user3.setPhoneNumber("0845678901");
        user3.setRole("user");
        user3.setBalance(500.0);
        user3.setActive(true);
        userRepository.save(user3);

        // Create Games
        Game game1 = new Game();
        game1.setName("Mobile Legends: Bang Bang");
        game1.setDescription("Popular MOBA game with millions of players worldwide");
        game1.setCategories("MOBA,Strategy,Multiplayer");
        game1.setImageUrl("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/fbcc8e98-1e32-4651-9919-367525a4ebf7/dis0mte-c3072f3f-b46b-40d1-8383-e9c24deabb8f.png/v1/fill/w_894,h_894/new_logo_mobile_legends_bang_bang_2024_png_by_wolvesdzn_dis0mte-pre.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTI4MCIsInBhdGgiOiJcL2ZcL2ZiY2M4ZTk4LTFlMzItNDY1MS05OTE5LTM2NzUyNWE0ZWJmN1wvZGlzMG10ZS1jMzA3MmYzZi1iNDZiLTQwZDEtODM4My1lOWMyNGRlYWJiOGYucG5nIiwid2lkdGgiOiI8PTEyODAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.DAtB5Os1_p_k3bsxziiLgTjuFPLGKLsmScc03TM8v3M");
        game1.setActive(true);
        game1.setPopular(false);
        game1.setOrderCount(0);
        gameRepository.save(game1);

        Game game2 = new Game();
        game2.setName("PUBG Mobile");
        game2.setDescription("Battle Royale game with intense action and strategy");
        game2.setCategories("Battle Royale,FPS,Multiplayer");
        game2.setImageUrl("https://i.pinimg.com/originals/2d/39/a5/2d39a5dc82c7daa18282c2ba38ec17f9.jpg");
        game2.setActive(true);
        game2.setPopular(true);
        game2.setOrderCount(0);
        gameRepository.save(game2);

        Game game3 = new Game();
        game3.setName("Free Fire");
        game3.setDescription("Fast-paced battle royale game for mobile devices");
        game3.setCategories("Battle Royale,FPS,Multiplayer");
        game3.setImageUrl("https://th.bing.com/th/id/R.5929f6c4cfd38f313e23c8562ed32ac2?rik=gH36D8RDmpP3pw&pid=ImgRaw&r=0");
        game3.setActive(true);
        game3.setPopular(false);
        game3.setOrderCount(0);
        gameRepository.save(game3);

        Game game4 = new Game();
        game4.setName("Genshin Impact");
        game4.setDescription("Open-world action RPG with stunning visuals");
        game4.setCategories("RPG,Adventure,Open World");
        game4.setImageUrl("https://www.fontshut.com/wp-content/uploads/2023/01/Genshin-Impact-Logo_PNG5.png");
        game4.setActive(true);
        game4.setPopular(true);
        game4.setOrderCount(0);
        gameRepository.save(game4);

        Game game5 = new Game();
        game5.setName("Call of Duty Mobile");
        game5.setDescription("First-person shooter with multiplayer modes");
        game5.setCategories("FPS,Action,Multiplayer");
        game5.setImageUrl("https://logowik.com/content/uploads/images/call-of-duty-mobile-new6549.logowik.com.webp");
        game5.setActive(true);
        game5.setPopular(false);
        game5.setOrderCount(0);
        gameRepository.save(game5);

        Game game6 = new Game();
        game6.setName("Rov");
        game6.setDescription("5v5 MOBA battle game with diverse heroes");
        game6.setCategories("MOBA,Strategy,Multiplayer");
        game6.setImageUrl("https://i.pinimg.com/originals/53/46/6f/53466f47042343f31de20355b93ff09c.jpg");
        game6.setActive(true);
        game6.setPopular(false);
        game6.setOrderCount(0);
        gameRepository.save(game6);

        Game game7 = new Game();
        game7.setName("Valorant");
        game7.setDescription("Tactical FPS game with unique agent abilities");
        game7.setCategories("FPS,Tactical,Multiplayer");
        game7.setImageUrl("https://tse3.mm.bing.net/th/id/OIP.N7O2KML05sPRlyIF5T6JHwHaE4?cb=12&rs=1&pid=ImgDetMain&o=7&rm=3");
        game7.setActive(true);
        game7.setPopular(true);
        game7.setOrderCount(0);
        gameRepository.save(game7);

        Game game8 = new Game();
        game8.setName("League of Legends");
        game8.setDescription("The world's most popular MOBA game");
        game8.setCategories("MOBA,Strategy,Esports");
        game8.setImageUrl("https://downtoday.co.uk/wp-content/uploads/2014/09/League-of-Legends-logo.jpg");
        game8.setActive(true);
        game8.setPopular(true);
        game8.setOrderCount(0);
        gameRepository.save(game8);
        
// Create Game Packages (1 package per game)
        
        // Mobile Legends Package
        GamePackage mlPackage = new GamePackage();
        mlPackage.setGame(game1);
        mlPackage.setName("100 Diamonds");
        mlPackage.setPrice(35.0);
        mlPackage.setDescription("Perfect starter bundle for Mobile Legends");
        mlPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        mlPackage.setActive(true);
        mlPackage.setOrderCount(0);
        packageRepository.save(mlPackage);

        // PUBG Mobile Package
        GamePackage pubgPackage = new GamePackage();
        pubgPackage.setGame(game2);
        pubgPackage.setName("500 UC");
        pubgPackage.setPrice(150.0);
        pubgPackage.setDescription("Get exclusive skins and items");
        pubgPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        pubgPackage.setActive(true);
        pubgPackage.setOrderCount(0);
        packageRepository.save(pubgPackage);

        // Free Fire Package
        GamePackage ffPackage = new GamePackage();
        ffPackage.setGame(game3);
        ffPackage.setName("1000 Diamonds");
        ffPackage.setPrice(300.0);
        ffPackage.setDescription("Premium bundle for Free Fire enthusiasts");
        ffPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        ffPackage.setActive(true);
        ffPackage.setOrderCount(0);
        packageRepository.save(ffPackage);

        // Genshin Impact Package
        GamePackage genshinPackage = new GamePackage();
        genshinPackage.setGame(game4);
        genshinPackage.setName("60 Genesis Crystals");
        genshinPackage.setPrice(35.0);
        genshinPackage.setDescription("Standard crystal pack for wishes");
        genshinPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        genshinPackage.setActive(true);
        genshinPackage.setOrderCount(0);
        packageRepository.save(genshinPackage);

        // Call of Duty Mobile Package
        GamePackage codPackage = new GamePackage();
        codPackage.setGame(game5);
        codPackage.setName("800 CP");
        codPackage.setPrice(250.0);
        codPackage.setDescription("COD Points for premium content");
        codPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        codPackage.setActive(true);
        codPackage.setOrderCount(0);
        packageRepository.save(codPackage);

        // ROV Package
        GamePackage rovPackage = new GamePackage();
        rovPackage.setGame(game6);
        rovPackage.setName("500 Vouchers");
        rovPackage.setPrice(180.0);
        rovPackage.setDescription("Unlock heroes and skins");
        rovPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        rovPackage.setActive(true);
        rovPackage.setOrderCount(0);
        packageRepository.save(rovPackage);

        // Valorant Package
        GamePackage valorantPackage = new GamePackage();
        valorantPackage.setGame(game7);
        valorantPackage.setName("1000 VP");
        valorantPackage.setPrice(320.0);
        valorantPackage.setDescription("Valorant Points for premium content");
        valorantPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        valorantPackage.setActive(true);
        valorantPackage.setOrderCount(0);
        packageRepository.save(valorantPackage);

        // League of Legends Package
        GamePackage lolPackage = new GamePackage();
        lolPackage.setGame(game8);
        lolPackage.setName("1380 RP");
        lolPackage.setPrice(400.0);
        lolPackage.setDescription("Riot Points for champions and skins");
        lolPackage.setImageUrl("https://i.pinimg.com/originals/01/7f/5e/017f5e1aa1c95e2fe5fc3b01f8556b88.jpg");
        lolPackage.setActive(true);
        lolPackage.setOrderCount(0);
        packageRepository.save(lolPackage);
      
        System.out.println("✅ Dummy data initialized successfully!");
        System.out.println("   - Users: " + userRepository.count());
        System.out.println("   - Games: " + gameRepository.count());
        System.out.println("   - Packages: " + packageRepository.count());
        System.out.println("   - Orders: " + topUpOrderRepository.count());
        System.out.println("\n📌 Test Login Credentials:");
        System.out.println("   Admin - username: admin, password: admin123");
        System.out.println("   User  - username: user, password: user123");
    }
}
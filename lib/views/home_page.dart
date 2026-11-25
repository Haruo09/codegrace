import 'package:flutter/material.dart';

import '../theme/catppuccin_theme.dart';
import 'quiz_page.dart';
import 'widgets/trail_node.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    MapTrailTab(),
    LeaderboardTab(),
    FriendsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: CatppuccinColors.surface1, width: 1),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: CatppuccinColors.mantle,
            selectedItemColor: CatppuccinColors.mauve,
            unselectedItemColor: CatppuccinColors.subtext0,
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.map),
                label: 'Fases',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard_outlined),
                activeIcon: Icon(Icons.leaderboard),
                label: 'Placar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_outlined),
                activeIcon: Icon(Icons.people_alt),
                label: 'Amigos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Aba 1: Trilha do Mapa de Fases
class MapTrailTab extends StatelessWidget {
  const MapTrailTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeGrace - Trilha de Aprendizado'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.local_fire_department,
              color: CatppuccinColors.yellow,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            // Header do Módulo
            const Card(
              color: CatppuccinColors.surface0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: CatppuccinColors.mauve),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Módulo 1: Introdução à Lógica',
                            style: TextStyle(
                              color: CatppuccinColors.text,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Pioneiras: Ada Lovelace & Grace Hopper',
                            style: TextStyle(color: CatppuccinColors.subtext0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Nó 1 (Disponível - Ada Lovelace)
            TrailNode(
              levelNumber: 1,
              title: 'Ada Lovelace & Lógica',
              stars: 3,
              isUnlocked: true,
              isCompleted: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizPage()),
                );
              },
            ),

            const SizedBox(height: 32),

            // Nó 2 (Bloqueado)
            const TrailNode(
              levelNumber: 2,
              title: 'Grace Hopper & Compiladores',
              stars: 0,
              isUnlocked: false,
              isCompleted: false,
              onTap: null,
            ),

            const SizedBox(height: 32),

            // Nó 3 (Bloqueado)
            const TrailNode(
              levelNumber: 3,
              title: 'Estruturas Condicionais em C',
              stars: 0,
              isUnlocked: false,
              isCompleted: false,
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}

// Aba 2: Placar / Leaderboard
class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  static const Color silverColor = Color(0xFFE6E9EF);
  static const Color bronzeColor = Color(0xFFD28956);
  static const Color mutedRankColor = Color(0xFF74798E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Placar da Comunidade')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Text(
              '1º',
              style: TextStyle(
                color: CatppuccinColors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            title: Text(
              'Grace Hopper',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            subtitle: Text(
              '1200 pts',
              style: TextStyle(color: CatppuccinColors.subtext0, fontSize: 18),
            ),
            trailing: Icon(Icons.emoji_events, color: CatppuccinColors.yellow),
          ),
          Divider(color: CatppuccinColors.surface1, thickness: 2),
          ListTile(
            leading: Text(
              '2º',
              style: TextStyle(
                color: silverColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            title: Text(
              'Ada Lovelace',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            subtitle: Text(
              '800 pts',
              style: TextStyle(color: CatppuccinColors.subtext0, fontSize: 18),
            ),
          ),
          Divider(color: CatppuccinColors.surface1, thickness: 2),
          ListTile(
            leading: Text(
              '3º',
              style: TextStyle(
                color: bronzeColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            title: Text(
              'Margaret Hamilton',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            subtitle: Text(
              '600 pts',
              style: TextStyle(color: CatppuccinColors.subtext0, fontSize: 18),
            ),
          ),
          Divider(color: CatppuccinColors.surface1, thickness: 2),
          ListTile(
            leading: Text(
              '4º',
              style: TextStyle(
                color: mutedRankColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            title: Text(
              'Carol Shaw',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            subtitle: Text(
              '200 pts',
              style: TextStyle(color: CatppuccinColors.subtext0, fontSize: 18),
            ),
          ),
          Divider(color: CatppuccinColors.surface1, thickness: 2),
          ListTile(
            leading: Text(
              '5º',
              style: TextStyle(
                color: mutedRankColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            title: Text(
              'Mary Kenneth Keller',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            subtitle: Text(
              '100 pts',
              style: TextStyle(color: CatppuccinColors.subtext0, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// Aba 3: Amigos
class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rede de Apoio e Amigos')),
      body: const Center(
        child: Text(
          'Conecte-se com outras estudantes de tecnologia!',
          style: TextStyle(color: CatppuccinColors.subtext0),
        ),
      ),
    );
  }
}

// Aba 4: Perfil
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: CatppuccinColors.mauve,
      minimumSize: const Size(double.infinity, 50),
      textStyle: const TextStyle(
        color: CatppuccinColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: CatppuccinColors.mauve,
              child: Icon(Icons.person, size: 40, color: CatppuccinColors.base),
            ),
            const SizedBox(height: 12),
            const Text(
              'Estudante CodeGrace',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'BCC - IFSP Salto',
              style: TextStyle(color: CatppuccinColors.subtext0),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              style: buttonStyle,
              onPressed: () {},
              child: const Text('Configurações de Conta'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {},
              child: const Text('Configurações de Som'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {},
              child: const Text('Configurações de Notificações'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/catppuccin_theme.dart';
import 'quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  
  final List<Widget> _tabs = [
    const MapTrailTab(),
    const LeaderboardTab(),
    const FriendsTab(),
    const ProfileTab(),
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
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: CatppuccinColors.mantle,
          selectedItemColor: CatppuccinColors.mauve,
          unselectedItemColor: CatppuccinColors.subtext0,
          type: BottomNavigationBarType.fixed,
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
    );
  }
}

// Aba 1: Trilha do Mapa de Fases (Inspirado no Protótipo)
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
            Card(
              color: CatppuccinColors.surface0,
              child: const Padding(
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
            _buildTrailNode(
              context: context,
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
            _buildTrailNode(
              context: context,
              levelNumber: 2,
              title: 'Grace Hopper & Compiladores',
              stars: 0,
              isUnlocked: false,
              isCompleted: false,
              onTap: null,
            ),

            const SizedBox(height: 32),

            // Nó 3 (Bloqueado)
            _buildTrailNode(
              context: context,
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

  Widget _buildTrailNode({
    required BuildContext context,
    required int levelNumber,
    required String title,
    required int stars,
    required bool isUnlocked,
    required bool isCompleted,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isUnlocked
                      ? CatppuccinColors.mauve
                      : CatppuccinColors.surface0,
                  border: Border.all(
                    color: isUnlocked
                        ? CatppuccinColors.lavender
                        : CatppuccinColors.surface1,
                    width: 3,
                  ),
                  boxShadow: isUnlocked
                      ? [
                          BoxShadow(
                            color: CatppuccinColors.mauve.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  isUnlocked ? Icons.play_arrow : Icons.lock,
                  color: isUnlocked
                      ? CatppuccinColors.base
                      : CatppuccinColors.subtext0,
                  size: 36,
                ),
              ),
              if (isUnlocked)
                Positioned(
                  bottom: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: CatppuccinColors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'FASE $levelNumber',
                      style: const TextStyle(
                        color: CatppuccinColors.base,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: isUnlocked
                  ? CatppuccinColors.text
                  : CatppuccinColors.subtext0,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (i) => Icon(
                i < stars ? Icons.star : Icons.star_border,
                color: CatppuccinColors.yellow,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Aba 2: Placar / Leaderboard
class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

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
          Divider(color: CatppuccinColors.surface1, thickness: 4),
          ListTile(
            leading: Text(
              '2º',
              style: TextStyle(
                color: Color.fromARGB(255, 234, 234, 234),
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
          Divider(color: CatppuccinColors.surface1, thickness: 4),
          ListTile(
            leading: Text(
              '3º',
              style: TextStyle(
                color: Color.fromARGB(255, 173, 104, 0),
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
          Divider(color: CatppuccinColors.surface1, thickness: 4),
          ListTile(
            leading: Text(
              '4º',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 113, 113),
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
          Divider(color: CatppuccinColors.surface1, thickness: 4),
          ListTile(
            leading: Text(
              '5º',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 113, 113),
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
          Divider(color: CatppuccinColors.surface1, thickness: 4),
          ListTile(
            leading: Text(
              '6º',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 113, 113),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            title: Text(
              'XXXXXX',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            subtitle: Text(
              '50 pts',
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
    final ButtonStyle style =  ElevatedButton.styleFrom(
      backgroundColor:  CatppuccinColors.mauve,
      minimumSize: const Size(double.infinity, 50),
      textStyle:  TextStyle(color: CatppuccinColors.text,
                              fontWeight: FontWeight.bold,
                               fontSize: 20),);
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        //padding: EdgeInsets.all(16),
        child: Column(
          children:[
            const Align(
            alignment: Alignment.center,
            ),
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
            style: style,
            onPressed: (){},
            child:  const Text('Configurações de Conta'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: style,
            onPressed: (){},
            child:  const Text('Configurações de Som'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: style,
            onPressed: (){},
            child:  const Text('Configurações de Notificações'),
          ),
          ],
        ),
      ),
    );
  }
}

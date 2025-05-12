import 'package:flutter/material.dart';
import 'package:vibesync/core/theme/app_theme.dart';
import 'package:vibesync/features/home/presentation/screens/home_screen.dart';
import 'package:vibesync/features/search/presentation/screens/search_screen.dart';
import 'package:vibesync/features/library/presentation/screens/library_screen.dart';
import 'package:vibesync/features/profile/presentation/screens/profile_screen.dart';
import 'package:vibesync/features/music/data/services/audio_player_service.dart';
import 'package:vibesync/features/music/presentation/widgets/mini_player.dart';
import 'package:vibesync/features/music/presentation/screens/player_screen.dart';

void main() {
  runApp(const VibeSyncApp());
}

class VibeSyncApp extends StatelessWidget {
  const VibeSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VibeSync',
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayerService.init();
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  void _showPlayerScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerScreen(
          audioPlayerService: _audioPlayerService,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MiniPlayer(
              audioPlayerService: _audioPlayerService,
              onTap: _showPlayerScreen,
            ),
            ),
          ],
        ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_music_outlined),
            selectedIcon: Icon(Icons.library_music),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

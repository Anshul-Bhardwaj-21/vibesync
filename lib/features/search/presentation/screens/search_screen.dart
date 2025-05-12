import 'package:flutter/material.dart';
import 'package:vibesync/core/theme/app_theme.dart';
import 'package:vibesync/features/music/data/services/audio_player_service.dart';
import 'package:vibesync/features/music/data/services/mock_data_service.dart';
import 'package:vibesync/features/music/domain/models/song.dart';
import 'package:vibesync/features/music/presentation/screens/player_screen.dart';

class SearchScreen extends StatefulWidget {
  final AudioPlayerService audioPlayerService;

  const SearchScreen({
    super.key,
    required this.audioPlayerService,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Song> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults = MockDataService.searchSongs(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text('Search', style: AppTheme.titleLarge),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search songs, artists, or albums',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _performSearch('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: AppTheme.surfaceColor,
                  ),
                  onChanged: _performSearch,
                ),
              ),
            ),
          ),
          if (_isSearching)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Search Results',
                  style: AppTheme.titleLarge,
                ),
              ),
            ),
          if (_searchResults.isEmpty && _isSearching)
            const SliverFillRemaining(
              child: Center(
                child: Text('No results found'),
              ),
            )
          else if (_searchResults.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final song = _searchResults[index];
                  return ListTile(
                    leading: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(song.coverUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      song.title,
                      style: AppTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      '${song.artist} • ${song.album}',
                      style: AppTheme.bodyMedium,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_circle_outline),
                      onPressed: () {
                        widget.audioPlayerService.playQueue(
                          _searchResults,
                          initialIndex: index,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                              audioPlayerService: widget.audioPlayerService,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: _searchResults.length,
              ),
            )
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Searches',
                      style: AppTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Pop',
                        'Rock',
                        'Hip Hop',
                        'Jazz',
                        'Classical',
                        'Electronic',
                      ].map((genre) {
                        return ActionChip(
                          label: Text(genre),
                          onPressed: () {
                            _searchController.text = genre;
                            _performSearch(genre);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
} 
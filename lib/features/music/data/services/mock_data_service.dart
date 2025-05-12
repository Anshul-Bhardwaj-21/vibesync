import 'package:vibesync/features/music/domain/models/song.dart';
import 'package:vibesync/features/music/domain/models/playlist.dart';

class MockDataService {
  static List<Song> getSongs() {
    return [
      Song(
        id: '1',
        title: 'Shape of You',
        artist: 'Ed Sheeran',
        album: '÷ (Divide)',
        coverUrl: 'https://picsum.photos/200/200?random=1',
        audioUrl: 'https://example.com/songs/shape-of-you.mp3',
        duration: const Duration(minutes: 3, seconds: 54),
        addedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Song(
        id: '2',
        title: 'Blinding Lights',
        artist: 'The Weeknd',
        album: 'After Hours',
        coverUrl: 'https://picsum.photos/200/200?random=2',
        audioUrl: 'https://example.com/songs/blinding-lights.mp3',
        duration: const Duration(minutes: 3, seconds: 20),
        addedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Song(
        id: '3',
        title: 'Dance Monkey',
        artist: 'Tones and I',
        album: 'The Kids Are Coming',
        coverUrl: 'https://picsum.photos/200/200?random=3',
        audioUrl: 'https://example.com/songs/dance-monkey.mp3',
        duration: const Duration(minutes: 3, seconds: 29),
        addedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Song(
        id: '4',
        title: 'Someone You Loved',
        artist: 'Lewis Capaldi',
        album: 'Divinely Uninspired to a Hellish Extent',
        coverUrl: 'https://picsum.photos/200/200?random=4',
        audioUrl: 'https://example.com/songs/someone-you-loved.mp3',
        duration: const Duration(minutes: 3, seconds: 2),
        addedAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Song(
        id: '5',
        title: 'Don\'t Start Now',
        artist: 'Dua Lipa',
        album: 'Future Nostalgia',
        coverUrl: 'https://picsum.photos/200/200?random=5',
        audioUrl: 'https://example.com/songs/dont-start-now.mp3',
        duration: const Duration(minutes: 3, seconds: 3),
        addedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  static List<Playlist> getPlaylists() {
    final songs = getSongs();
    return [
      Playlist(
        id: '1',
        name: 'Top Hits 2023',
        description: 'The best songs of 2023',
        coverUrl: 'https://picsum.photos/200/200?random=10',
        songs: songs,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Playlist(
        id: '2',
        name: 'Chill Vibes',
        description: 'Relaxing music for your day',
        coverUrl: 'https://picsum.photos/200/200?random=11',
        songs: songs.reversed.toList(),
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      Playlist(
        id: '3',
        name: 'Workout Mix',
        description: 'High energy songs for your workout',
        coverUrl: 'https://picsum.photos/200/200?random=12',
        songs: songs,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
  }

  static List<Song> searchSongs(String query) {
    final songs = getSongs();
    return songs
        .where((song) =>
            song.title.toLowerCase().contains(query.toLowerCase()) ||
            song.artist.toLowerCase().contains(query.toLowerCase()) ||
            song.album.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
} 
import 'package:just_audio/just_audio.dart';
import 'package:vibesync/features/music/domain/models/song.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Song? _currentSong;
  List<Song> _queue = [];
  int _currentIndex = -1;
  bool _isShuffleEnabled = false;
  bool _isRepeatEnabled = false;

  // Getters
  Song? get currentSong => _currentSong;
  List<Song> get queue => _queue;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _audioPlayer.playing;
  bool get isShuffleEnabled => _isShuffleEnabled;
  bool get isRepeatEnabled => _isRepeatEnabled;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  // Initialize the player
  Future<void> init() async {
    await _audioPlayer.setLoopMode(LoopMode.off);
  }

  // Play a single song
  Future<void> playSong(Song song) async {
    if (_currentSong?.id == song.id) {
      await _audioPlayer.play();
      return;
    }

    _currentSong = song;
    await _audioPlayer.setUrl(song.audioUrl);
    await _audioPlayer.play();
  }

  // Play a list of songs
  Future<void> playQueue(List<Song> songs, {int initialIndex = 0}) async {
    _queue = songs;
    _currentIndex = initialIndex;
    await playSong(songs[initialIndex]);
  }

  // Add songs to queue
  void addToQueue(List<Song> songs) {
    _queue.addAll(songs);
  }

  // Play next song
  Future<void> playNext() async {
    if (_queue.isEmpty) return;

    if (_isShuffleEnabled) {
      _currentIndex = _getRandomIndex();
    } else {
      _currentIndex = (_currentIndex + 1) % _queue.length;
    }

    await playSong(_queue[_currentIndex]);
  }

  // Play previous song
  Future<void> playPrevious() async {
    if (_queue.isEmpty) return;

    if (_isShuffleEnabled) {
      _currentIndex = _getRandomIndex();
    } else {
      _currentIndex = (_currentIndex - 1 + _queue.length) % _queue.length;
    }

    await playSong(_queue[_currentIndex]);
  }

  // Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  // Seek to position
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Toggle shuffle
  void toggleShuffle() {
    _isShuffleEnabled = !_isShuffleEnabled;
  }

  // Toggle repeat
  void toggleRepeat() {
    _isRepeatEnabled = !_isRepeatEnabled;
    _audioPlayer.setLoopMode(
      _isRepeatEnabled ? LoopMode.all : LoopMode.off,
    );
  }

  // Get random index for shuffle
  int _getRandomIndex() {
    if (_queue.length <= 1) return 0;
    int newIndex;
    do {
      newIndex = DateTime.now().millisecondsSinceEpoch % _queue.length;
    } while (newIndex == _currentIndex);
    return newIndex;
  }

  // Dispose
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
} 
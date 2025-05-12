import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../../shared/models/track.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Track? _currentTrack;
  bool _isInitialized = false;

  AudioPlayer get player => _audioPlayer;
  Track? get currentTrack => _currentTrack;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (!_isInitialized) {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.speech());
      _isInitialized = true;
    }
  }

  Future<void> playTrack(Track track) async {
    if (!_isInitialized) await initialize();
    
    if (_currentTrack?.id != track.id) {
      await _audioPlayer.setUrl(track.audioUrl);
      _currentTrack = track;
    }
    
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentTrack = null;
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed);
  }

  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  Stream<bool> get playingStream => _audioPlayer.playingStream;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
    _isInitialized = false;
  }
} 
import 'package:flutter/material.dart';
import 'package:vibesync/core/theme/app_theme.dart';
import 'package:vibesync/features/music/data/services/audio_player_service.dart';
import 'package:vibesync/features/music/domain/models/song.dart';

class PlayerScreen extends StatelessWidget {
  final AudioPlayerService audioPlayerService;

  const PlayerScreen({
    super.key,
    required this.audioPlayerService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: StreamBuilder<Song?>(
        stream: Stream.value(audioPlayerService.currentSong),
        builder: (context, snapshot) {
          final song = snapshot.data;
          if (song == null) return const SizedBox.shrink();

          return SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        _buildAlbumArt(song),
                        const SizedBox(height: 32),
                        _buildSongInfo(song),
                        const SizedBox(height: 32),
                        _buildProgressBar(song),
                        const SizedBox(height: 32),
                        _buildControls(),
                        const SizedBox(height: 32),
                        _buildQueueButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Now Playing',
            style: AppTheme.titleLarge,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show more options
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt(Song song) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          song.coverUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSongInfo(Song song) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            song.title,
            style: AppTheme.headlineMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            song.artist,
            style: AppTheme.bodyLarge,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(Song song) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          StreamBuilder<Duration>(
            stream: audioPlayerService.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              return SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 16,
                  ),
                  activeTrackColor: AppTheme.primaryColor,
                  inactiveTrackColor: Colors.white24,
                  thumbColor: AppTheme.primaryColor,
                  overlayColor: AppTheme.primaryColor.withOpacity(0.2),
                ),
                child: Slider(
                  value: position.inMilliseconds.toDouble(),
                  max: song.duration.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    audioPlayerService.seekTo(
                      Duration(milliseconds: value.toInt()),
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<Duration>(
                  stream: audioPlayerService.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    return Text(
                      _formatDuration(position),
                      style: AppTheme.bodyMedium,
                    );
                  },
                ),
                Text(
                  _formatDuration(song.duration),
                  style: AppTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              audioPlayerService.isShuffleEnabled
                  ? Icons.shuffle
                  : Icons.shuffle_outlined,
              color: audioPlayerService.isShuffleEnabled
                  ? AppTheme.primaryColor
                  : Colors.white,
            ),
            onPressed: () {
              audioPlayerService.toggleShuffle();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.skip_previous,
              size: 48,
            ),
            onPressed: () {
              audioPlayerService.playPrevious();
            },
          ),
          StreamBuilder<bool>(
            stream: Stream.value(audioPlayerService.isPlaying),
            builder: (context, snapshot) {
              final isPlaying = snapshot.data ?? false;
              return IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  size: 64,
                  color: AppTheme.primaryColor,
                ),
                onPressed: () {
                  audioPlayerService.togglePlayPause();
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.skip_next,
              size: 48,
            ),
            onPressed: () {
              audioPlayerService.playNext();
            },
          ),
          IconButton(
            icon: Icon(
              audioPlayerService.isRepeatEnabled
                  ? Icons.repeat
                  : Icons.repeat_outlined,
              color: audioPlayerService.isRepeatEnabled
                  ? AppTheme.primaryColor
                  : Colors.white,
            ),
            onPressed: () {
              audioPlayerService.toggleRepeat();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQueueButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // TODO: Show queue
      },
      icon: const Icon(Icons.queue_music),
      label: const Text('Queue'),
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
} 
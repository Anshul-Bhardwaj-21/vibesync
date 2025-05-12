class Track {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String coverUrl;
  final String audioUrl;
  final Duration duration;
  final List<String> genres;
  final String language;
  final bool isExplicit;
  final bool isDownloaded;
  final bool isFavorite;
  final DateTime releaseDate;
  final int playCount;
  final Map<String, dynamic> metadata;

  Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverUrl,
    required this.audioUrl,
    required this.duration,
    required this.genres,
    required this.language,
    this.isExplicit = false,
    this.isDownloaded = false,
    this.isFavorite = false,
    required this.releaseDate,
    this.playCount = 0,
    this.metadata = const {},
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      coverUrl: json['coverUrl'] as String,
      audioUrl: json['audioUrl'] as String,
      duration: Duration(milliseconds: json['duration'] as int),
      genres: List<String>.from(json['genres'] as List),
      language: json['language'] as String,
      isExplicit: json['isExplicit'] as bool? ?? false,
      isDownloaded: json['isDownloaded'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      playCount: json['playCount'] as int? ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'coverUrl': coverUrl,
      'audioUrl': audioUrl,
      'duration': duration.inMilliseconds,
      'genres': genres,
      'language': language,
      'isExplicit': isExplicit,
      'isDownloaded': isDownloaded,
      'isFavorite': isFavorite,
      'releaseDate': releaseDate.toIso8601String(),
      'playCount': playCount,
      'metadata': metadata,
    };
  }

  Track copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? coverUrl,
    String? audioUrl,
    Duration? duration,
    List<String>? genres,
    String? language,
    bool? isExplicit,
    bool? isDownloaded,
    bool? isFavorite,
    DateTime? releaseDate,
    int? playCount,
    Map<String, dynamic>? metadata,
  }) {
    return Track(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      coverUrl: coverUrl ?? this.coverUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      genres: genres ?? this.genres,
      language: language ?? this.language,
      isExplicit: isExplicit ?? this.isExplicit,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isFavorite: isFavorite ?? this.isFavorite,
      releaseDate: releaseDate ?? this.releaseDate,
      playCount: playCount ?? this.playCount,
      metadata: metadata ?? this.metadata,
    );
  }
} 
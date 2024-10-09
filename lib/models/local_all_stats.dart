import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medito/models/local_audio_completed.dart';
import 'package:medito/models/stats/all_stats_model.dart';

part 'local_all_stats.g.dart';

@JsonSerializable()
class LocalAllStats {
  final int streakCurrent;
  final int streakLongest;
  final int streakLastDate;
  final int totalTracksCompleted;
  final int totalTimeListened;
  final List<String>? tracksFavorited;
  final List<String>?  tracksCompleted;
  final List<String>? announcementsDismissed;
  final List<LocalAudioCompleted>? audioCompleted;
  final int updated;

  LocalAllStats({
    required this.streakCurrent,
    required this.streakLongest,
    required this.streakLastDate,
    required this.totalTracksCompleted,
    required this.totalTimeListened,
    required this.tracksFavorited,
    required this.tracksCompleted,
    required this.announcementsDismissed,
    required this.audioCompleted,
    required this.updated,
  });

  factory LocalAllStats.empty() {
    return LocalAllStats(
      streakCurrent: 0,
      streakLongest: 0,
      streakLastDate: 0,
      totalTracksCompleted: 0,
      totalTimeListened: 0,
      tracksFavorited: [],
      tracksCompleted: [],
      announcementsDismissed: [],
      audioCompleted: [],
      updated: 0,
    );
  }

  factory LocalAllStats.fromAllStats(AllStats stats) {
    return LocalAllStats(
      streakCurrent: stats.streakCurrent,
      streakLongest: stats.streakLongest,
      streakLastDate: stats.streakLastDate,
      totalTracksCompleted: stats.totalTracksCompleted,
      totalTimeListened: stats.totalTimeListened,
      tracksFavorited: stats.tracksFavorited ?? [],
      tracksCompleted: stats.tracksCompleted ?? [],
      announcementsDismissed: stats.announcementsDismissed ?? [],
      audioCompleted: stats.audioCompleted?.map((e) => LocalAudioCompleted.fromAudioCompleted(e)).toList() ?? [],
      updated: stats.updated,
    );
  }

  AllStats toAllStats() {
    return AllStats(
      streakCurrent: streakCurrent,
      streakLongest: streakLongest,
      streakLastDate: streakLastDate,
      totalTracksCompleted: totalTracksCompleted,
      totalTimeListened: totalTimeListened,
      tracksFavorited: tracksFavorited,
      tracksCompleted: tracksCompleted,
      announcementsDismissed: announcementsDismissed,
      audioCompleted: audioCompleted?.map((e) => e.toAudioCompleted()).toList(),
      updated: updated,
    );
  }

  factory LocalAllStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAllStatsFromJson(json);

  Map<String, dynamic> toJson() => _$LocalAllStatsToJson(this);

  LocalAllStats copyWith({
    int? streakCurrent,
    int? streakLongest,
    int? streakLastDate,
    int? totalTracksCompleted,
    int? totalTimeListened,
    List<String>? tracksFavorited,
    List<String>? tracksCompleted,
    List<String>? announcementsDismissed,
    List<LocalAudioCompleted>? audioCompleted,
    int? updated,
  }) {  
    return LocalAllStats(
      streakCurrent: streakCurrent ?? this.streakCurrent,
      streakLongest: streakLongest ?? this.streakLongest,
      streakLastDate: streakLastDate ?? this.streakLastDate,
      totalTracksCompleted: totalTracksCompleted ?? this.totalTracksCompleted,
      totalTimeListened: totalTimeListened ?? this.totalTimeListened,
      tracksFavorited: tracksFavorited ?? this.tracksFavorited,
      tracksCompleted: tracksCompleted ?? this.tracksCompleted,
      announcementsDismissed:
          announcementsDismissed ?? this.announcementsDismissed,
      audioCompleted: audioCompleted ?? this.audioCompleted,
      updated: updated ?? this.updated,
    );
  }

} 

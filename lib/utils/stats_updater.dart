import '../constants/types/type_constants.dart';
import 'health_kit_manager.dart';
import 'stats_manager.dart';
import '../models/local_audio_completed.dart';

Future<bool> handleStats(
  Map<String, dynamic> payload,
) async {
  var healthKitManager = HealthKitManager();
  var permitted = await healthKitManager.isHealthSyncPermitted() == true;
  if (!permitted) {
    await healthKitManager.requestAuthorization();
  }

  if (!await healthKitManager
      .isSessionSynced(payload[TypeConstants.timestampIdKey])) {
    var success = await _updateHealthKit(payload);
    if (success) {
      await healthKitManager
          .markSessionAsSynced(payload[TypeConstants.timestampIdKey]);
    }
  }

  var statsManager = StatsManager();

  var newAudioCompleted = LocalAudioCompleted(
    id: payload[TypeConstants.trackIdKey],
    timestamp: payload[TypeConstants.timestampIdKey],
  );

  var duration = payload[TypeConstants.durationIdKey];

  try {
    await statsManager.addAudioCompleted(newAudioCompleted, duration);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> _updateHealthKit(Map<String, dynamic> payload) async {
  final end = DateTime.fromMillisecondsSinceEpoch(
    payload[TypeConstants.timestampIdKey],
  );
  final start = end
      .subtract(Duration(milliseconds: payload[TypeConstants.durationIdKey]));

  return await HealthKitManager().writeMindfulnessData(start, end);
}

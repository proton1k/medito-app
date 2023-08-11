import 'package:Medito/models/models.dart';
import 'package:Medito/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'play_pause_button_widget.dart';

class PlayerButtonsWidget extends ConsumerWidget {
  const PlayerButtonsWidget({
    super.key,
    required this.meditationModel,
    required this.file,
  });
  final MeditationFilesModel file;
  final MeditationModel meditationModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _rewindButton(ref),
        SizedBox(width: 35),
        _playPauseButton(),
        SizedBox(width: 35),
        _forwardButton(ref),
      ],
    );
  }

  InkWell _rewindButton(WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(
        skipAudioProvider(skip: SKIP_AUDIO.SKIP_BACKWARD_10),
      ),
      child: Icon(
        Icons.replay_10,
        size: 40,
      ),
    );
  }

  InkWell _forwardButton(WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(
        skipAudioProvider(skip: SKIP_AUDIO.SKIP_FORWARD_30),
      ),
      child: Icon(
        Icons.forward_30,
        size: 40,
      ),
    );
  }

  Widget _playPauseButton() {
    return PlayPauseButtonWidget();
  }
}

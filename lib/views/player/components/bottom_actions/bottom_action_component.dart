import 'package:Medito/constants/constants.dart';
import 'package:Medito/models/models.dart';
import 'package:Medito/routes/routes.dart';
import 'package:Medito/views/player/components/bottom_actions/components/audio_speed_component.dart';
import 'package:Medito/views/player/components/bottom_actions/components/labels_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/audio_download_component.dart';

class BottomActionComponent extends StatelessWidget {
  const BottomActionComponent(
      {super.key,
      required this.sessionModel,
      required this.file,
      required this.isDownloaded});
  final SessionModel sessionModel;
  final SessionFilesModel file;
  final bool isDownloaded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AudioSpeedComponent(),
          width8,
          AudioDownloadComponent(
            sessionModel: sessionModel,
            file: file,
            isDownloaded: isDownloaded,
          ),
          width8,
          if (sessionModel.hasBackgroundSound)
            LabelsComponent(
              label: StringConstants.SOUND.toUpperCase(),
              onTap: () {
                var location = GoRouter.of(context).location;
                print(location + backgroundSounds);
                context.go(location + backgroundSounds,
                    extra: {'sessionModel': sessionModel, 'file': file});
              },
            ),
          if (sessionModel.hasBackgroundSound) width8,
        ],
      ),
    );
  }
}

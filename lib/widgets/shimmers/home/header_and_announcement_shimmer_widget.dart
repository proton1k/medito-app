import 'package:medito/constants/styles/widget_styles.dart';
import 'package:flutter/material.dart';

import '../widgets/box_shimmer_widget.dart';

class HeaderAndAnnouncementShimmerWidget extends StatelessWidget {
  const HeaderAndAnnouncementShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: padding16),
          child: BoxShimmerWidget(
            height: 200,
            borderRadius: 12,
          ),
        ),
      ],
    );
  }

  Padding _header() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding16,
        vertical: padding16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BoxShimmerWidget(
            height: 40,
            width: 150,
            borderRadius: 12,
          ),
          BoxShimmerWidget(
            height: 35,
            width: 15,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }
}

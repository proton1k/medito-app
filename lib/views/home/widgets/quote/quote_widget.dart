import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medito/constants/colors/color_constants.dart';
import 'package:medito/constants/strings/string_constants.dart';
import 'package:medito/constants/styles/widget_styles.dart';
import 'package:medito/models/home/home_model.dart';
import 'package:medito/widgets/snackbar_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:medito/utils/utils.dart';

class QuoteWidget extends ConsumerWidget {
  const QuoteWidget({super.key, required this.data});

  final HomeQuoteModel? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var globalKey = GlobalKey();
    final quoteStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: sourceSerif,
          fontWeight: FontWeight.w300,
          fontSize: 18,
          height: 1.4,
          color: ColorConstants.white,
        );

    final authorStyle = quoteStyle?.copyWith(
      color: ColorConstants.white.withOpacity(0.6),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height16,
        const Padding(
          padding: EdgeInsets.only(left: padding16),
          child: Text(
            'Daily Quote',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: teachers,
              fontSize: 20,
              height: 28 / 24,
            ),
          ),
        ),
        height8,
        GestureDetector(
          onTap: () => _handleShare(context, globalKey),
          child: RepaintBoundary(
            key: globalKey,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: ColorConstants.onyx,
              ),
              margin: const EdgeInsets.symmetric(horizontal: padding16),
              padding: const EdgeInsets.all(padding16),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildBackgroundIcon(),
                  _buildQuoteContent(quoteStyle, authorStyle),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleShare(BuildContext context, GlobalKey key) async {
    try {
      var file = await capturePng(context, key);
      if (file != null) {
        var shareText = '${data?.quote}\n- ${data?.author}\n\n${StringConstants.shareStatsText}';
        
        await Share.shareXFiles(
          [XFile(file.path)],
          text: shareText,
        );
      } else {
        showSnackBar(context, StringConstants.someThingWentWrong);
      }
    } catch (e) {
      showSnackBar(context, StringConstants.someThingWentWrong);
    }
  }

  Widget _buildBackgroundIcon() {
    return Positioned(
      top: -30,
      right: -20,
      child: Opacity(
        opacity: 0.07,
        child: HugeIcon(
          icon: Icons.format_quote,
          color: ColorConstants.white,
          size: 100,
        ),
      ),
    );
  }

  Widget _buildQuoteContent(TextStyle? quoteStyle, TextStyle? authorStyle) {
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data?.quote != null)
            Padding(
              padding: const EdgeInsets.only(right: 60.0),
              child: Text(
                data!.quote,
                style: quoteStyle,
              ),
            ),
          if (data?.author != null) ...[
            height4,
            Text(
              data!.author,
              style: authorStyle,
            ),
          ],
        ],
      ),
    );
  }
}

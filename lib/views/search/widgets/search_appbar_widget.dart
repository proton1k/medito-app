import 'package:Medito/constants/constants.dart';
import 'package:Medito/providers/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchAppbarWidget extends ConsumerStatefulWidget {
  const SearchAppbarWidget({super.key});
  @override
  ConsumerState<SearchAppbarWidget> createState() => _SearchAppbarWidgetState();
}

class _SearchAppbarWidgetState extends ConsumerState<SearchAppbarWidget> {
  bool showCancelIcon = false;
  FocusNode searchInputFocusNode = FocusNode();
  var textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = ref.read(searchQueryProvider);
    showCancelIcon = textEditingController.text != '';
    super.initState();
  }

  void openKeyboard() {
    FocusScope.of(context).requestFocus(searchInputFocusNode);
    setState(() {
      showCancelIcon = false;
    });
  }

  void handleCancelIconVisibility(String val) {
    if (val.isNotEmpty && !showCancelIcon) {
      setState(() {
        showCancelIcon = true;
      });
    } else if (val.isEmpty && showCancelIcon) {
      setState(() {
      showCancelIcon = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var outlineInputBorder = _outlineInputBorder();

    return AppBar(
      backgroundColor: ColorConstants.onyx,
      elevation: 0.0,
      titleSpacing: 0,
      leading: IconButton(
        splashRadius: 20,
        onPressed: () => context.pop(),
        icon: Icon(Icons.arrow_back),
      ),
      title: TextFormField(
        focusNode: searchInputFocusNode,
        controller: textEditingController,
        cursorColor: ColorConstants.walterWhite,
        cursorWidth: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 11.5),
          suffixIcon: Visibility(
            visible: showCancelIcon,
            child: IconButton(
              splashRadius: 20,
              onPressed: () {
                ref.read(searchQueryProvider.notifier).state = '';
                textEditingController.text = '';
                openKeyboard();
              },
              icon: Icon(
                Icons.close,
                color: ColorConstants.walterWhite,
              ),
            ),
          ),
          hintText: StringConstants.whatAreYouLookingFor,
          hintStyle: textTheme.titleSmall
              ?.copyWith(color: ColorConstants.walterWhite.withOpacity(0.6)),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: outlineInputBorder,
        ),
        textInputAction: TextInputAction.search,
        autofocus: true,
        onFieldSubmitted: (val) {
          ref.read(searchQueryProvider.notifier).state = val;
        },
        onChanged: (val) => handleCancelIconVisibility(val),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder({
    Color color = ColorConstants.onyx,
  }) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 0),
        borderRadius: BorderRadius.circular(15),
      );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/editing_history_provider.dart';
import '../theme/color.dart';
import '../theme/text.dart';

class GroupTag extends ConsumerWidget {
  const GroupTag({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setHistory = ref.watch(editingHistoryProvider.notifier);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: kPrimaryGreen,
        backgroundColor: kPrimaryGreen.withOpacity(0.16),
        onSurface: kSecondaryGray,
        side: BorderSide.none,
        // onSurface: kSecondaryGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: bodyText2.copyWith(color: kPrimaryGreen),
          ),
          const SizedBox(width: 8),
          const Icon(CupertinoIcons.xmark_circle, color: kPrimaryGreen),
        ],
      ),
      onPressed: () {
        setHistory.removeGroup(title);
      },
    );
  }
}

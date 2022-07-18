import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/history_store_provider.dart';
import '../theme/color.dart';

class LoadedSettingIndicatorCard extends ConsumerWidget {
  const LoadedSettingIndicatorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyStore = ref.watch(historyStoreProvider);

    String stateString() {
      if (historyStore.isEmpty) {
        return '設定ファイルが読み込まれていません。';
      } else {
        return '${historyStore.length} 個の薬歴/トレースが読み込まれています。';
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: historyStore.isEmpty
              ? kSecondaryGray.withOpacity(0.16)
              : kPrimaryGreen.withOpacity(0.16)),
      child: Text(
        '現在のステータス : ${stateString()}',
        style: bodyText2.copyWith(
            color: historyStore.isEmpty ? kPrimaryBlack : kPrimaryGreen),
      ),
    );
  }
}

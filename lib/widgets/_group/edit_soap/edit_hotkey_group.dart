import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/editing_history_provider.dart';
import '../../../screen/soap_edit_screen.dart';
import '../../button/group_tag.dart';
import '../../card/soap_card.dart';
import '../../theme/color.dart';

class EditableHotKeyAndGroup extends ConsumerWidget {
  const EditableHotKeyAndGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingHistoryState = ref.watch(editingHistoryProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: kSecondaryGray.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddDrugHistoryHotKey(),
                const SizedBox(
                  height: 12,
                ),
                const AddDrugHistoryGroup(),
                const SizedBox(
                  height: 20,
                ),
                editingHistoryState.group.isNotEmpty
                    ? Wrap(
                        direction: Axis.horizontal,
                        spacing: 8,
                        runSpacing: 12,
                        children: editingHistoryState.group
                            .map((e) => GroupTag(title: e))
                            .toList(),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SoapCard(),
      ],
    );
  }
}

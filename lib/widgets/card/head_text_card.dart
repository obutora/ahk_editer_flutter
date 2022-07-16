import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/edit_step_provider.dart';
import '../theme/text.dart';

class HeadTextCard extends ConsumerWidget {
  const HeadTextCard(
      {Key? key,
      required this.title,
      required this.description,
      this.isWithButton = false})
      : super(key: key);

  final String title;
  final String description;
  final bool isWithButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editStepProvider);
    final setEditStep = ref.watch(editStepProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: headText,
            ),
            const SizedBox(width: 12),
            isWithButton
                ? ElevatedButton.icon(
                    onPressed: () {
                      setEditStep.changeIsSoap();
                    },
                    icon: const Icon(
                        CupertinoIcons.arrow_uturn_right_circle_fill),
                    label: Text(editState.isSoap ? 'トレースへ変更' : 'SOAPへ変更'))
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          child: Text(
            description,
            style: captionText1,
          ),
        ),
      ],
    );
  }
}

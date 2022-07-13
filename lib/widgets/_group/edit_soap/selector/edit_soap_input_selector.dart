import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/edit_step_provider.dart';
import '../../../../screen/soap_edit_screen.dart';
import '../../../editable_drug_history.dart';
import '../../../theme/color.dart';

class EditSoapInputSelecter extends ConsumerWidget {
  const EditSoapInputSelecter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editStepState = ref.watch(editStepProvider);

    switch (editStepState) {
      case 0:
        return const EditableDrugHistory();
      case 1:
        return Padding(
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
              children: const [
                AddDrugHistoryHotKey(),
                SizedBox(
                  height: 12,
                ),
                AddDrugHistoryGroup(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      default:
        return const Text('error');
    }
  }
}

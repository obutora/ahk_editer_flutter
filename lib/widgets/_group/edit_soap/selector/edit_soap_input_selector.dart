import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/edit_step_provider.dart';
import '../editable_drug_history.dart';
import '../edit_hotkey_group.dart';
import '../save_soap.dart';

class EditSoapInputSelecter extends ConsumerWidget {
  const EditSoapInputSelecter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editStepState = ref.watch(editStepProvider);

    switch (editStepState) {
      case 0:
        return const EditableDrugHistory();
      case 1:
        return const EditableHotKeyAndGroup();
      case 2:
        return const SaveSoapWidget();
      default:
        return const Text('error');
    }
  }
}

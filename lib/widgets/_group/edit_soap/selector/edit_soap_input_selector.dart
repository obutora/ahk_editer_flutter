import 'package:ahk_editor_flutter/widgets/_group/edit_soap/editable_trace.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/edit_step_provider.dart';
import '../editable_drug_history.dart';
import '../edit_hotkey_group.dart';
import '../save_soap.dart';

class EditSelecter extends ConsumerWidget {
  const EditSelecter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editStepState = ref.watch(editStepProvider);

    switch (editStepState.step) {
      case 0:
        if (editStepState.isSoap) {
          return const EditableDrugHistory();
        } else {
          return const EditableTrace();
        }
      case 1:
        return const EditableHotKeyAndGroup();
      case 2:
        return const SaveSoapWidget();
      default:
        return const Text('error');
    }
  }
}

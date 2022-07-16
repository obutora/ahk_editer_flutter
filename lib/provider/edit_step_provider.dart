import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:ahk_editor_flutter/widgets/snackbar/soap_alert.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editStepProvider = StateNotifierProvider<EditStepNotifier, int>((ref) {
  return EditStepNotifier();
});

class EditStepNotifier extends StateNotifier<int> {
  EditStepNotifier() : super(0);

  void change(int index) {
    state = index;
  }

  void clear() {
    state = 0;
  }

  void next(DrugHistory history, BuildContext context) {
    switch (state) {
      case 0:
        if (history.soapList.isNotEmpty) {
          state++;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(soapAlertSnackBar);
        }
        break;
      case 1:
        if (history.hotString.isNotEmpty) {
          state++;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(hotStringAlertSnackBar);
        }
        break;
    }
    // state++;
  }

  void back() {
    state--;
  }
}

// final editStepControllerProvider = Provider<int>(((ref) {
//   final editStep = ref.watch(editStepProvider);


// });

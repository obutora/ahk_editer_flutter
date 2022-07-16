import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:ahk_editor_flutter/widgets/snackbar/soap_alert.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editStepProvider =
    StateNotifierProvider<EditStepNotifier, HistoryEditEtep>((ref) {
  return EditStepNotifier();
});

class EditStepNotifier extends StateNotifier<HistoryEditEtep> {
  EditStepNotifier() : super(HistoryEditEtep(isSoap: true, step: 0));

  void change(int index) {
    state = state.copyWith(step: index);
  }

  void changeIsSoap() {
    state = state.copyWith(isSoap: !state.isSoap);
  }

  void clear() {
    state = HistoryEditEtep(isSoap: true, step: 0);
  }

  void next(DrugHistory history, BuildContext context) {
    switch (state.step) {
      case 0:
        if (history.soapList.isNotEmpty) {
          state = state.copyWith(step: 1);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(soapAlertSnackBar);
        }
        break;
      case 1:
        if (history.hotString.isNotEmpty) {
          state = state.copyWith(step: 2);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(hotStringAlertSnackBar);
        }
        break;
    }
    // state++;
  }

  void back() {
    state = state.copyWith(step: state.step - 1);
  }
}

class HistoryEditEtep {
  final int step;
  final bool isSoap;

  HistoryEditEtep({
    required this.step,
    required this.isSoap,
  });

  HistoryEditEtep copyWith({
    int? step,
    bool? isSoap,
  }) {
    return HistoryEditEtep(
      step: step ?? this.step,
      isSoap: isSoap ?? this.isSoap,
    );
  }
}

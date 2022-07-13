import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../entity/soap.dart';

const uuid = Uuid();

final editingHistoryProvider =
    StateNotifierProvider<EditingHistoryNotifier, DrugHistory>((ref) {
  return EditingHistoryNotifier();
});

class EditingHistoryNotifier extends StateNotifier<DrugHistory> {
  EditingHistoryNotifier()
      : super(
            DrugHistory(id: uuid.v4(), group: [], hotString: '', soapList: []));

  void clear() {
    state = DrugHistory(id: uuid.v4(), group: [], hotString: '', soapList: []);
  }

  void addSoap(Soap soap) {
    if (soap.body.isNotEmpty) {
      state = state.copyWith(soapList: [...state.soapList, soap]);
    }
  }

  void hotString(String word) {
    state = state.copyWith(hotString: word);
  }

  void clearHotString() {
    state = state.copyWith(hotString: '');
  }

  void removeSoap(String soapId) {
    state = state.copyWith(
        soapList: state.soapList.where((e) => e.id != soapId).toList());
  }

  void setHotString(String hotString) {
    state = state.copyWith(hotString: hotString);
  }
}

import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final historyStoreProvider =
    StateNotifierProvider<HistoryStoreNotifier, List<DrugHistory>>((ref) {
  return HistoryStoreNotifier();
});

class HistoryStoreNotifier extends StateNotifier<List<DrugHistory>> {
  HistoryStoreNotifier() : super([]);

  void init(List<DrugHistory> value) async {
    state = value;

    // print(state.length);
    // print(state.map((e) => e.soapList).toList());
  }

  void add(DrugHistory history) {
    state = [...state, history];
  }

  void remove(DrugHistory history) {
    state = state.where((e) => e.id != history.id).toList();
  }

  bool isExistFromId(String id) {
    return state.any((e) => e.id == id);
  }

  bool isExistFromHotString(String hotString) {
    return state.any((e) => e.hotString == hotString);
  }

  DrugHistory getHistoryFromId(String id) {
    return state.firstWhere((e) => e.id == id);
  }

  DrugHistory getHistoryFromHotString(String hotString) {
    return state.firstWhere((e) => e.hotString == hotString);
  }

  List<DrugHistory> getAll() {
    return state;
  }

  // String getHotkeyFromId(String id) {
  //   return state.firstWhere((e) => e.id == id).hotString;
  // }
}

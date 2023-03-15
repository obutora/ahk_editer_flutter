import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'history_store_provider.dart';

// 薬歴検索ワードのProvider
final searchHistoryWordProvider = StateProvider<String>((ref) => '血圧');

// 検索ワードで絞り込んだ薬歴リストを返すProvider
final searchHistoryProvider = Provider((ref) {
  final word = ref.watch(searchHistoryWordProvider);
  final historyList = ref.watch(historyStoreProvider);

  return historyList
      .where((history) =>
          history.soapList.any((soap) => soap.body.contains(word)) ||
          history.group.any((group) => group.contains(word)))
      .toList();
});

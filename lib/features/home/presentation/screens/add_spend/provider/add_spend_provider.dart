import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/presentation/screens/add_spend/model/add_spend_model.dart';
import 'package:todo/features/home/presentation/screens/add_spend/sevice/add_spend_service.dart';

class AddSpendNotifier extends StateNotifier<AsyncValue<List<AddSpendModel>>> {
  final AddSpendService _service;

  AddSpendNotifier(this._service) : super(const AsyncValue.loading()) {
    fetchSpends();
  }

  Future<void> fetchSpends() async {
    try {
      final spends =
          await _service.getAllSpends(); // getAllSpends metodunu yazacağız
      state = AsyncValue.data(spends);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSpend(AddSpendModel model) async {
    try {
      await _service.addSpendFromModel(model);
      fetchSpends(); // yeniden yükle
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final addSpendServiceProvider = Provider<AddSpendService>((ref) {
  return AddSpendService();
});

final addSpendProvider =
    StateNotifierProvider<AddSpendNotifier, AsyncValue<List<AddSpendModel>>>((
      ref,
    ) {
      final service = ref.read(addSpendServiceProvider);
      return AddSpendNotifier(service);
    });

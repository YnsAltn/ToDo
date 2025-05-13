import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/presentation/screens/settings/state/settings_state.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  void toggleDarkMode() =>
      state = state.copyWith(isDarkMode: !state.isDarkMode);
  void toggleSync() => state = state.copyWith(isSyncOn: !state.isSyncOn);
  void toggleNotifications() =>
      state = state.copyWith(
        areNotificationsEnabled: !state.areNotificationsEnabled,
      );
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);

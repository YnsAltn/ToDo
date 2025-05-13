class SettingsState {
  final bool isDarkMode;
  final bool isSyncOn;
  final bool areNotificationsEnabled;

  SettingsState({
    this.isDarkMode = false,
    this.isSyncOn = false,
    this.areNotificationsEnabled = true,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? isSyncOn,
    bool? areNotificationsEnabled,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSyncOn: isSyncOn ?? this.isSyncOn,
      areNotificationsEnabled:
          areNotificationsEnabled ?? this.areNotificationsEnabled,
    );
  }
}

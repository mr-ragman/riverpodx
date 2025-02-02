library riverpodx;

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A custom extension on [Ref] to simplify state management.
///
/// Dart implementation
extension RiverpodXRef on Ref {
  /// Reads the state of a provider.
  ///
  /// [provider] is the provider whose state is to be accessed.
  /// Returns the current state of the provider.
  T readState<T>(ProviderBase<T> provider) => read(provider);

  /// Modifies the state of a provider.
  ///
  /// For accessing StateNotifier: N should alway be a `StateNotifier`
  /// [provider] is the provider whose state is to be updated.
  /// This function will call the [notifier] of the provider to mutate its state automatically.
  N state<N extends StateNotifier<dynamic>>(
      StateNotifierProvider<N, dynamic> provider) {
    return read(provider.notifier);
  }
}

/// A custom extension on [WidgetRef] to simplify state management.
extension RiverpodXFlutter on WidgetRef {
  /// Reads the state of a provider.
  ///
  /// [provider] is the provider whose state is to be accessed.
  /// Returns the current state of the provider.
  T readState<T>(ProviderBase<T> provider) => read(provider);

  /// Watches the state of a provider and rebuilds when it changes.
  ///
  /// [provider] is the provider to watch. It listens to changes and updates UI accordingly.
  T watchState<T>(ProviderBase<T> provider) => watch(provider);

  /// Modifies the state of a provider.
  ///
  /// For accessing StateNotifier: N should alway be a `StateNotifier`
  /// [provider] is the provider whose state is to be updated.
  /// This function will call the [notifier] of the provider to mutate its state automatically.
  N state<N extends StateNotifier<dynamic>>(
      StateNotifierProvider<N, dynamic> provider) {
    return read(provider.notifier);
  }
}

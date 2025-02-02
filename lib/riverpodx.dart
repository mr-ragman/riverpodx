library riverpodx;

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Extension for Dart Only
extension RiverpodXRef on Ref {
  T readState<T>(ProviderBase<T> provider) => read(provider);

  // N should always be a `StateNotifier`
  N state<N extends StateNotifier<dynamic>>(
      StateNotifierProvider<N, dynamic> provider) {
    return read(provider.notifier);
  }
}

// Extension for Flutter (using WidgetRef)
extension RiverpodXFlutter on WidgetRef {

  T readState<T>(ProviderBase<T> provider) => read(provider);

  // Used for reading the state reactively
  T watchState<T>(ProviderBase<T> provider) => watch(provider);

  // For accessing StateNotifier: N should alway be a `StateNotifier`
  N state<N extends StateNotifier<dynamic>>(
      StateNotifierProvider<N, dynamic> provider) {
    return read(provider.notifier);
  }
}

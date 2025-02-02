import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodx/riverpodx.dart';

// Create a simple Counter StateNotifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
}

void main() {
  test('Simple extension test', () {
    final container = ProviderContainer();
    final simpleProvider = Provider<String>((ref) => 'test');

    // accessing ref on container directly, doesn't work! :(
    final refProvider = Provider((ref) {
      ref.readState(simpleProvider);
      return ref;
    });

    expect(container.read(simpleProvider), 'test');
    expect(container.read(refProvider).readState(simpleProvider), 'test');
  });

  test('WidgetRef simple provider extension test', () {
    final container = ProviderContainer();
    final simpleProvider = Provider<String>((ref) => 'test');

    final widgetRef = _TestWidgetRef(container);

    expect(widgetRef.readState(simpleProvider), 'test');
    expect(widgetRef.watchState(simpleProvider), 'test');
  });

  test('State notifiers extension test', () {
    final container = ProviderContainer();

    // State notifiers
    final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
      return CounterNotifier();
    });

    final widgetRef = _TestWidgetRef(container);

    expect(widgetRef.readState(counterProvider), 0);

    // Update State state directly
    widgetRef.state(counterProvider).state = 10;
    expect(widgetRef.readState(counterProvider), 10);
    expect(widgetRef.watchState(counterProvider), 10);

    // update state using increment method
    widgetRef.state(counterProvider).increment();
    expect(widgetRef.readState(counterProvider), 11);
    expect(widgetRef.watchState(counterProvider), 11);
  });
}

class _TestWidgetRef implements WidgetRef {
  final ProviderContainer _container;

  _TestWidgetRef(this._container);

  @override
  T read<T>(ProviderListenable<T> provider) => _container.read(provider);

  @override
  T watch<T>(ProviderListenable<T> provider) => _container.read(provider);

  @override
  bool exists(ProviderBase provider) => _container.exists(provider);

  @override
  void invalidate(ProviderOrFamily provider) => _container.invalidate(provider);

  @override
  State refresh<State>(Refreshable<State> provider) =>
      _container.refresh(provider);

  @override
  ProviderSubscription<T> listen<T>(
    ProviderListenable<T> provider,
    void Function(T? previous, T next) listener, {
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return _container.listen(provider, listener, onError: onError);
  }

  @override
  BuildContext get context =>
      throw UnimplementedError('context is not available in tests');

  @override
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T? previous, T next) listener, {
    void Function(Object error, StackTrace stackTrace)? onError,
    bool fireImmediately = false,
  }) {
    return _container.listen(
      provider,
      listener,
      onError: onError,
      fireImmediately: fireImmediately,
    );
  }
}

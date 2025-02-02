# RiverpodX: Simplifying Riverpod Common APIs for Readability and Ease of Use 🚀🔥

![Tests](https://github.com/mr-ragman/riverpodx/actions/workflows/test.yml/badge.svg)

`RiverpodX` is a lightweight helper package designed to simplify the Riverpod API for state management in both Flutter and Dart applications. The goal of this package is to reduce cognitive load by providing more intuitive and readable ways to interact with providers and state management logic.

## Why RiverpodX?

While Riverpod is a powerful and flexible state management solution, its API can sometimes feel complex, especially when managing multiple types of providers or interacting with `StateNotifier` or `StateProvider`. 

`RiverpodX` offers intuitive extensions to streamline and simplify these interactions, making the code easier to read, understand, and maintain.

## Extensions Overview

- **`readState()`**: As it says on the tin! It reads the current state of a provider (one-time read).

- **`watchState()`**: Watches a provider _**reactively**_ for updates (useful for Flutter).

- **`state()`**: Accesses the state of a `StateNotifier` or `StateProvider` for mutation or reading.


## Installation

To get started, add `riverpodx` to your `pubspec.yaml`:

```yaml
dependencies:
  # riverpod: ^2.4.0 # dart
  flutter_riverpod: ^2.4.0
  riverpodx: ^0.1.0
```

Then, run:

```bash
flutter pub get
```

## Usage - Dart

Once installed, you can start using the simplified Riverpod API in your project. Here's an example of how to use the new extensions:

```dart
// Example: Using `readState` and `state` extensions

import 'package:riverpodx/riverpodx.dart';  // RiverpodX package 

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

final counter = container.readState(counterProvider);
print(counter);  // Output: 0

// Update state. Notice we don't see notifier anywhere!
final conterState = container.state(counterProvider).increment();

final updatedCounter = container.readState(counterProvider);
print(updatedCounter);  // Output: 1
```

## Usage in Flutter

In Flutter, `RiverpodX` extensions integrate seamlessly with `WidgetRef` and make state management even simpler. By using these extensions, you can easily access or modify state from within your widgets.

Here’s an example of how to use `RiverpodX` in your Flutter widgets with the `ref` extensions:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodx/riverpodx.dart';  // RiverpodX package 


// Define a simple Counter StateNotifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use `watchState`
    final counter = ref.watchState(counterProvider);

    return Column(
      children: [
        Text('Counter: $counter'),
        ElevatedButton(
          onPressed: () {
            // Access `state()` directly
            ref.state(counterProvider).increment();
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

## Benefits of RiverpodX

- **Reduced Boilerplate**: Access and modify state directly with `.state()` — no need for verbose calls to `.notifier`. It’s simple, clean, and saves you from mental overhead.
  
- **Increased Productivity**: Spend less time second-guessing which API to use. RiverpodX uses intuitive extensions that align with how you naturally think about state management, making common operations feel familiar and easy to implement.

- **Clear and Clean Code**: `RiverpodX` aims to keep code clear, readable and intuitive. Instead of using `ref.read(...)` when what you really want is to update state, use the straightforward `ref.state()` which takes care of the `.notifier` calls automatically for you.

### Interested in Contributing?

If you have ideas or improvements for `RiverpodX`, feel free to fork the repo and open a pull request! We welcome contributions that improve usability and simplify the development process using the fantastic [riverpod](https://riverpod.dev/) library. Thanks to the riverpod team for the awesome work!

### License

MIT License. See [LICENSE](LICENSE) for more details.

---

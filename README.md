# MarqueeWidget

A Flutter widget that infinitely scrolls its child widget horizontally. `MarqueeWidget` is highly customizable, offering a range of options including custom scroll directions, durations.

_Appreciate the widget? Show some ❤️ and star the repo to support the project!_

## Features

- Infinitely scroll a widget horizontally.
- Customizable scrolling speed (velocity).
- Customizable gap between repetitions of the scrolling widget.
- Optional left-to-right or right-to-left scrolling.
- Customizable height for the scrolling area.

## Installation

Add `marquee_widget` to your `pubspec.yaml`:

```yaml
dependencies:
  marquee_widget: ^0.1.0
```

Then run `flutter packages get`

## Usage

Here's a simple example to get you started:

```dart
import 'package:marquee_widget/marquee_widget.dart';

MarqueeWidget(
movingWidget: Text('Scrolling text here'),
)
```

And here's a more advanced example demonstrating the full customizability of the MarqueeWidget:

```dart
MarqueeWidget(
movingWidget: Text('Scrolling text here'),
gap: 0.5,
velocity: 100.0,
moveDirectionLtr: true,
height: 50.0,
)
```

## API Reference

For a detailed list of all available properties and their usage, please refer to the API documentation.

## Contributing

Contributions are welcome! If you have a bug to report or feature to request, please open an issue. If you'd like to contribute code (bug fixes, new features), please open a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

<!-- ## Acknowledgments

Thanks to all the contributors who have helped to enhance and improve MarqueeWidget.
Inspired by the Flutter community's need for an easy-to-use, customizable marquee widget. -->

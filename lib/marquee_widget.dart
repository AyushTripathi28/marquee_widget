library marquee_widget;

import 'package:flutter/material.dart';

/// A horizontally scrolling container that continuously scrolls its content.
///
/// [MarqueeWidget] takes a widget and automatically scrolls it horizontally,
/// repeating the widget with a specified gap in between each repetition.
///
/// ## Sample code
///
/// ```dart
/// MarqueeWidget(
///   movingWidget: Text('Scrolling text or any other widget'),
///   gap: 10,
///   velocity: 30,
///   moveDirectionLtr: false,
///   height: 20,
/// )
/// ```
///
/// See also:
///
/// * [movingWidget] to provide the widget to be scrolled.
/// * [velocity] to set the speed of scrolling.
class MarqueeWidget extends StatefulWidget {
  /// The widget to be scrolled.
  ///
  /// This widget will be repeated and scrolled continuously.
  ///
  /// ## Sample code
  ///
  /// ```dart
  /// MarqueeWidget(
  ///   movingWidget: Text('Scrolling text or any other widget'),
  /// )
  /// ```
  final Widget movingWidget;

  /// The gap or blank space to display between each instance of the widget..
  ///
  /// ## Sample code
  ///
  /// In this example, there's a gap of width 10 between each instance of the widget.
  /// should be greater than equal to 0:
  ///
  /// ```dart
  /// MarqueeWidget(
  ///   movingWidget: Text('Scrolling text'),
  ///   gap: 10,
  /// )
  /// ```
  final double gap;

  /// The speed of scrolling in pixels per second.
  ///
  /// ## Sample code
  ///
  /// This MarqueeWidget scrolls at 30 pixels per second.
  /// Change the velocity to change the speed of scrolling:
  ///
  /// ```dart
  /// MarqueeWidget(
  ///   movingWidget: Text('Scrolling text or any other widget'),
  ///   velocity: 30,
  /// )
  /// ```
  final double velocity;

  /// Whether the scrolling should be left-to-right. Default is false (right-to-left).
  ///
  /// ## Sample code
  ///
  /// This MarqueeWidget scrolls from left to right:
  ///
  /// ```dart
  /// MarqueeWidget(
  ///   movingWidget: Text('Scrolling text or any other widget'),
  ///   moveDirectionLtr: true,
  /// )
  /// ```
  final bool moveDirectionLtr;

  /// The height of the scrolling area.
  ///
  /// ## Sample code
  ///
  /// This MarqueeWidget has a defualt height of 20 pixels.
  /// But you can change it to according to your need:
  ///
  /// ```dart
  /// MarqueeWidget(
  ///   movingWidget: Text('Scrolling text'),
  ///   height: 50,
  /// )
  /// ```
  final double height;

  const MarqueeWidget({
    Key? key,
    this.gap = 10,
    required this.movingWidget,
    this.velocity = 30,
    this.moveDirectionLtr = false,
    this.height = 20,
  })  : assert(gap >= 0, 'Gap must be greater than and equal to 0.'),
        assert(velocity >= 0, 'Velocity must be greater than and equal to 0.'),
        assert(height >= 15, 'Height must be greater than and equal to 0.'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => MarqueeWidgetState();
}

class MarqueeWidgetState extends State<MarqueeWidget>
    with SingleTickerProviderStateMixin {
  /// Controls the animation for scrolling.
  late final AnimationController _scrollAnimationController;

  /// Controls the position of the scrollable widget.
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize the scroll controller.
    _scrollController = ScrollController();

    // Initialize the animation controller with a specified duration.
    _scrollAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
    )..addListener(_scroll);
  }

  /// Starts the scrolling animation.
  ///
  /// If the animation is already running, it stops it before restarting.
  void _startScrolling() {
    if (_scrollAnimationController.isAnimating) {
      _scrollAnimationController.stop();
    }
    _scrollAnimationController.repeat();
  }

  /// Handles the continuous scrolling logic.
  ///
  /// Calculates the move distance based on the velocity and updates the scroll position.
  void _scroll() {
    double moveDistance = widget.velocity * 0.06;

    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      _scrollController.jumpTo(0.0);
    } else {
      _scrollController.jumpTo(_scrollController.offset + moveDistance);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Start the scrolling animation once the layout is built.
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  @override
  void dispose() {
    // Dispose of the controllers to free up resources.
    _scrollAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Builds the horizontally scrolling list.
  ///
  /// This method constructs the list with the appropriate height, scroll direction, and content.
  Widget _buildScrollingList() {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: widget.moveDirectionLtr,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return index.isEven
              ? widget.movingWidget
              : SizedBox(width: widget.gap);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Builds the widget using the _buildScrollingList method.
    return _buildScrollingList();
  }
}

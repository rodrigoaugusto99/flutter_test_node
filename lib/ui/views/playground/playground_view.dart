import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'playground_viewmodel.dart';

class PlaygroundView extends StackedView<PlaygroundViewModel> {
  const PlaygroundView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PlaygroundViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('animations'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('physics'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('convert'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('path'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('gestures'),
          ),
        ],
      ),
    );
  }

  @override
  PlaygroundViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlaygroundViewModel();
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class VolumeSliderPart extends StatelessWidget {
  const VolumeSliderPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final volume =
        context.select<MainViewModel, double>((viewModel) => viewModel.volume);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.volumeXmark),
          Expanded(
            child: Slider(
              min: 0.0,
              max: 100.0,
              inactiveColor: Colors.white.withOpacity(0.3),
              activeColor: Colors.white,
              divisions: 100,
              label: volume.round().toString(),
              value: volume,
              onChanged: (newVolume) => _changeVolume(newVolume, context),
            ),
          ),
          Icon(FontAwesomeIcons.volumeHigh),
        ],
      ),
    );
  }

  _changeVolume(double newVolume, BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    viewModel.changeVolume(newVolume);
  }
}

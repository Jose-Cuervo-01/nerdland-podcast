import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:provider/provider.dart';

class ProgressSlider extends StatefulWidget {
  @override
  _ProgressSliderState createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  PlayerControlBloc _playerControlBloc;

  @override
  void didChangeDependencies() {
    _playerControlBloc = Provider.of<PlayerControlBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _playerControlBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _playerControlBloc.playStatus$,
      builder: (context, AsyncSnapshot<PlayStatus> snapshot) {
        if (snapshot.hasData) {
          return Slider(
            min: 0.0,
            max: 1.0,
            value: snapshot.data.currentPosition / snapshot.data.duration,
            onChanged: (sliderValue) {
              int timeToSnapTo = (snapshot.data.duration * sliderValue).toInt();
              _playerControlBloc.seek(timeToSnapTo);
            },
          );
        } else {
          return Slider(
            value: 0.0,
            onChanged: null,
          );
        }
      },
    );
  }
}

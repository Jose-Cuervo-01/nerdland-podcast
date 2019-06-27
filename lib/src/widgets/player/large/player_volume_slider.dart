import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:provider/provider.dart';

class PlayerVolumeSlider extends StatefulWidget {
  @override
  _PlayerVolumeSliderState createState() => _PlayerVolumeSliderState();
}

class _PlayerVolumeSliderState extends State<PlayerVolumeSlider> {
  PlayerControlBloc _playerControlBloc;

  @override
  void didChangeDependencies() {
    _playerControlBloc = Provider.of<PlayerControlBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.volume_mute,
          size: 20.0,
          color: Colors.white70,
        ),
        Expanded(
          child: StreamBuilder(
            stream: _playerControlBloc.currentlyVolume$,
            builder: (context, AsyncSnapshot<double> snapshot) {
              if (snapshot.hasData) {
                print('volume= ${snapshot.data}');
                return Slider(
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.35),
                  value: snapshot.data,
                  onChanged: (sliderValue) {
                    _playerControlBloc.setVolume(sliderValue);
                  },
                );
              } else {
                return Slider(
                  value: 1.0,
                  onChanged: null,
                );
              }
            },
          ),
        ),
        Icon(
          Icons.volume_up,
          size: 20.0,
          color: Colors.white70,
        ),
      ],
    );
  }
}

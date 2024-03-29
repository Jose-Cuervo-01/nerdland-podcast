import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:provider/provider.dart';

class PlayerButton extends StatefulWidget {
  @override
  _PlayerButtonState createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<PlayerButton> {
  PlayerControlBloc _playerControlBloc;

  @override
  void didChangeDependencies() {
    _playerControlBloc = Provider.of<PlayerControlBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
      stream: _playerControlBloc.isPlaying$,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return IconButton(
          iconSize: 22.0,
          color: Colors.white,
          icon: snapshot.data == true
              ? Icon(Icons.pause)
              : Icon(Icons.play_arrow),
          onPressed: () {
            if (snapshot.data) {
              _pause();
            } else {
              _play();
            }
          },
        );
      },
    );
  }

  void _play() async {
    _playerControlBloc.play();
  }

  void _pause() async {
    _playerControlBloc.pause();
  }
}

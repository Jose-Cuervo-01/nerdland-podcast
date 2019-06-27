import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:provider/provider.dart';

class PlayerButtonLarge extends StatefulWidget {
  @override
  _PlayerButtonLargeState createState() => _PlayerButtonLargeState();
}

class _PlayerButtonLargeState extends State<PlayerButtonLarge> {
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
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          isExtended: true,
          child: snapshot?.data ?? false == true
              ? Icon(Icons.pause)
              : Icon(Icons.play_arrow),
          onPressed: () {
            if (snapshot?.data ?? false) {
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

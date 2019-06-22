import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:provider/provider.dart';

class PlayerTimeStamp extends StatefulWidget {
  @override
  _PlayerTimeStampState createState() => _PlayerTimeStampState();
}

class _PlayerTimeStampState extends State<PlayerTimeStamp> {
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
      builder: (BuildContext context, AsyncSnapshot<PlayStatus> snapshot) {
        if (snapshot.hasData) {
          int millisecondsLeft =
              (snapshot.data.duration - snapshot.data.currentPosition)
                  .truncate()
                  .toInt();
          int minutesLeft = millisecondsLeft ~/ 60000;

          // TODO: Move to ThemeBuilder
          return Text(
            '$minutesLeft min left',
            style: Theme.of(context).textTheme.caption,
          );
        } else {
          return Text('..');
        }
      },
    );
  }
}

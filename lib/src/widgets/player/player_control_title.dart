import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:provider/provider.dart';

class PlayerControlTitle extends StatefulWidget {
  @override
  _PlayerControlTitleState createState() => _PlayerControlTitleState();
}

class _PlayerControlTitleState extends State<PlayerControlTitle> {
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
      stream: _playerControlBloc.currentlyPlaying$,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        if (snapshot.hasData) {
          String podcastTitle = snapshot.data.title;
          // TODO: Move to ThemeBuilder
          return Text(
            '$podcastTitle',
            style: Theme.of(context).textTheme.body1,
          );
        } else {
          return Text('..');
        }
      },
    );
  }
}

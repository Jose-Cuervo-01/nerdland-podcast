import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/theme/theme_builder.dart';

import 'package:provider/provider.dart';

import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/blocs/podcasts_bloc.dart';

import 'package:nerdland_podcast/src/screens/home_screen.dart';

void main() => runApp(NerdlandPodcast());

class NerdlandPodcast extends StatefulWidget {
  @override
  _NerdlandPodcastState createState() => _NerdlandPodcastState();
}

class _NerdlandPodcastState extends State<NerdlandPodcast> {
  PodcastsBloc _podcastsBloc;
  PlayerControlBloc _playerControlBloc;

  @override
  void didChangeDependencies() {
    _podcastsBloc = PodcastsBloc();
    _playerControlBloc = PlayerControlBloc();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(builder: (_) => _podcastsBloc),
        Provider(builder: (_) => _playerControlBloc),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeBuilder.buildLightTheme(),
        home: HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _podcastsBloc.dispose();
    _playerControlBloc.dispose();
    super.dispose();
  }
}

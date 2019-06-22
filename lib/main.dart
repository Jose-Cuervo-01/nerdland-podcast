import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/blocs/podcasts_bloc.dart';

import 'package:nerdland_podcast/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          Provider(builder: (_) => PlayerControlBloc()),
          Provider(builder: (_) => PodcastsBloc()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}

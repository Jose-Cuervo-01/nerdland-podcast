import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/services/podcast_service.dart';
import 'package:http/http.dart' as http;
import 'package:nerdland_podcast/src/widgets/player/index.dart';
import 'package:nerdland_podcast/src/widgets/podcast/podcast_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final PodcastService _podcastService = PodcastService(client: http.Client());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Text('Nerdland Podcast'),
      elevation: 0,
    );
  }

  Widget get body {
    return Provider<PlayerControlBloc>(
      builder: (_) => PlayerControlBloc(),
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              padding:
                  const EdgeInsets.fromLTRB(20.0,0.0,20.0,0),
              child: FutureBuilder(
                //TODO: move to bloc
                future: _podcastService.fetchPodcasts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Podcast> podcasts = snapshot.data;
                    return PodcastList(
                      podcasts: podcasts,
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _podcastService.fetchPodcasts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PlayerControls();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}

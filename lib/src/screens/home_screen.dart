import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/services/podcast_service.dart';
import 'package:http/http.dart' as http;
import 'package:nerdland_podcast/src/widgets/podcast/podcast_list.dart';

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
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: FutureBuilder(
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
          child: Container(
            color: Colors.pink,
          ),
        )
      ],
    );
  }
}

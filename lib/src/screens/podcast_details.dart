import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/widgets/player/large/player_controls_large.dart';

class PodcastDetails extends StatelessWidget {
  final Podcast podcast;

  PodcastDetails({@required this.podcast});

  @override
  Widget build(BuildContext context) {
    final double topWidgetHeight =
        MediaQuery.of(context).size.height / 2 * 0.60;

    // print(_samePodcast());
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: topWidgetHeight,
                ),
                _buildPodcastDetails(context),
              ],
            ),
            Positioned(
              top: 65.0,
              left: MediaQuery.of(context).size.width / 2 - 150,
              // width: MediaQuery.of(context).size.width / 2,
              child: SizedBox(
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage.assetNetwork(
                    fadeInDuration: const Duration(milliseconds: 350),
                    placeholder: 'assets/images/placeholder.jpg',
                    alignment: Alignment.center,
                    image: podcast.itunes.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPodcastDetails(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.only(top: 100),
      child: Container(
        margin: EdgeInsets.fromLTRB(40.0, 70.0, 40.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${podcast.title.split('Nerdland').last.trim()}',
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              'NERDLAND PODCAST',
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .copyWith(color: Colors.white70),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                '${podcast.content}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  height: 1.25,
                ),
              ),
            ),
            Container(
              // height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: PlayerControlsLarge(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

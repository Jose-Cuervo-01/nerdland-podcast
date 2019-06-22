import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/screens/podcast_details.dart';
import 'package:provider/provider.dart';

class PodcastItem extends StatelessWidget {
  final Podcast podcast;

  PodcastItem({Key key, @required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerControlBloc _playerControlBloc =
        Provider.of<PlayerControlBloc>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PodcastDetails(podcast: podcast),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(right: 10.0),
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.assetNetwork(
                    fadeInDuration: const Duration(milliseconds: 350),
                    placeholder: 'assets/images/placeholder.jpg',
                    image: podcast.itunes.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildPodcastTitle(context),
                  // TODO: Move text themes to a ThemeBuilder
                  Text(
                    _formatDate(podcast.isoDate).toUpperCase(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          wordSpacing: 2.5,
                          color: Colors.black26,
                          fontSize: 11.0,
                        ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.play_circle_outline),
                onPressed: () => _playerControlBloc.selectAndPlay(podcast),
                color: Theme.of(context).iconTheme.color.withOpacity(0.25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildPodcastTitle(BuildContext context) {
    return Text(
      podcast.title,
      style: Theme.of(context)
          .textTheme
          .subhead
          .copyWith(fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  String _formatDate(DateTime dateUploaded) {
    var difference = DateTime.now().difference(dateUploaded);
    return '${difference.inDays} dagen geleden';
  }
}

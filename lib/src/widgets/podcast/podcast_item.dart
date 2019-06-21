import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';

class PodcastItem extends StatelessWidget {
  final Podcast podcast;

  PodcastItem({Key key, @required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: <Widget>[
          Container(
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
          Flexible(
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
        ],
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

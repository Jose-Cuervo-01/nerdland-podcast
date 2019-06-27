import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/screens/podcast_details.dart';
import 'package:provider/provider.dart';

class PodcastItem extends StatefulWidget {
  final Podcast podcast;

  PodcastItem({Key key, @required this.podcast}) : super(key: key);

  @override
  _PodcastItemState createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  PlayerControlBloc _playerControlBloc;

  @override
  void didChangeDependencies() async {
    _playerControlBloc = Provider.of<PlayerControlBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _playerControlBloc.select(widget.podcast);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PodcastDetails(podcast: widget.podcast),
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
                    image: widget.podcast.itunes.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildPodcastTitle(context),
                  Text(
                    _formatDate(widget.podcast.isoDate).toUpperCase(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          wordSpacing: 2.5,
                          color: Colors.black26,
                          fontSize: 11.0,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodcastTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Text(
        widget.podcast.title.split('Nerdland').last.trim(),
        style: Theme.of(context).textTheme.subhead,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String _formatDate(DateTime dateUploaded) {
    var difference = DateTime.now().difference(dateUploaded);
    return '${difference.inDays} ${difference.inDays == 1 ? 'dag' : 'dagen'} geleden';
  }
}

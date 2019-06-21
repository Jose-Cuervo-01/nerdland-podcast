import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/widgets/podcast/podcast_item.dart';

class PodcastList extends StatefulWidget {
  final List<Podcast> podcasts;

  PodcastList({@required this.podcasts});

  @override
  _PodcastListState createState() => _PodcastListState();
}

class _PodcastListState extends State<PodcastList> {
  List<Podcast> podcasts;
  bool sortedByOldest = false;

  @override
  void initState() {
    super.initState();
    podcasts = widget.podcasts;
    // TODO: Pre-cache the images
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40.0,
          child: tableHeader,
        ),
        Expanded(
          child: tableList,
        ),
      ],
    );
  }

  Widget get tableHeader {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Available episodes'),
        IconButton(
          icon: Icon(
            Icons.sort,
            color: sortedByOldest ? Colors.blue : Colors.pink,
          ),
          onPressed: () {
            sortedByOldest = !sortedByOldest;
            List<Podcast> sorted = widget.podcasts
              ..sort(
                (p1, p2) => sortedByOldest
                    ? p1.isoDate.compareTo(p2.isoDate)
                    : p2.isoDate.compareTo(p1.isoDate),
              );
            setState(() {
              podcasts = sorted;
            });
          },
        ),
      ],
    );
  }

  ListView get tableList {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        return PodcastItem(
          key: Key(podcasts[index].guid),
          podcast: podcasts[index],
        );
      },
      // Needs to be a high number to cache the list items
      // Otherwise the network image gets reloaded if the
      // cacheExtent is not set
      cacheExtent: 1500,
    );
  }
}

import 'dart:async';

import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/services/podcast_service.dart';
import 'package:http/http.dart' as http;

class PodcastsBloc {
  List<Podcast> _podcasts;

  PodcastService _podcastService = PodcastService(client: http.Client());

  StreamController<List<Podcast>> _podcastsController =
      StreamController.broadcast();

  Stream<List<Podcast>> get podcasts$ =>
      _podcastsController.stream.asBroadcastStream();

  PodcastsBloc() {
    fetchPodcasts();
  }

  void fetchPodcasts() async {
    _podcasts = await _podcastService.fetchPodcasts();
    _podcastsController.add(_podcasts);
  }

  void dispose() {
    _podcastsController.stream.drain();
    _podcastsController.close();
  }
}

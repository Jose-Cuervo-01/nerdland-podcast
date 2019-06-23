import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/services/podcast_service.dart';

class PodcastsBloc {
  List<Podcast> _podcasts;

  PodcastService _podcastService = PodcastService(client: http.Client());

  BehaviorSubject<List<Podcast>> _podcastsController = BehaviorSubject();

  Stream<List<Podcast>> get podcasts$ => _podcastsController.stream;

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

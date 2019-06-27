import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nerdland_podcast/src/config/constants.dart';

import 'package:nerdland_podcast/src/models/podcast.dart';

class PodcastService {
  final http.Client client;
  String url;
  int port;

  PodcastService({@required this.client}) {
    url = Constants.productionBackendUrl;
    port = Constants.backendPort;
  }

  Future<List<Podcast>> fetchPodcasts() async {
    final response = await client.get('$url/podcasts');
    // final response = await client.get('$url:$port/podcasts');
    Future<List<Podcast>> podcastsFuture;
    if (response.statusCode == 200) {
      podcastsFuture = compute(parsePodcasts, response.body);
    } else {
      throw Exception(
          'Failed to fetch podcasts, statuscode: ${response.statusCode}');
    }
    return podcastsFuture;
  }
}

List<Podcast> parsePodcasts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Podcast>((json) => Podcast.fromJson(json)).toList();
}

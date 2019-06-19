class Podcast {
  final String title;
  final String link;
  final String pubDate;
  final Enclosure enclosure;
  final String content;
  final String contentSnippet;
  final String guid;
  final DateTime isoDate;
  final Itunes itunes;

  Podcast({
    this.title,
    this.link,
    this.pubDate,
    this.enclosure,
    this.content,
    this.contentSnippet,
    this.guid,
    this.isoDate,
    this.itunes,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) => Podcast(
        title: json['title'],
        link: json['link'],
        pubDate: json['pubDate'],
        enclosure: Enclosure.fromJson(json['enclosure']),
        content: json['content'],
        contentSnippet: json['contentSnippet'],
        guid: json['guid'],
        isoDate: DateTime.parse(json['isoDate']),
        itunes: Itunes.fromJson(json['itunes']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'link': link,
        'pubDate': pubDate,
        'enclosure': enclosure.toJson(),
        'content': content,
        'contentSnippet': contentSnippet,
        'guid': guid,
        'isoDate': isoDate.toIso8601String(),
        'itunes': itunes.toJson(),
      };
}

class Enclosure {
  final String type;
  final String url;
  final String length;

  Enclosure({
    this.type,
    this.url,
    this.length,
  });

  factory Enclosure.fromJson(Map<String, dynamic> json) => new Enclosure(
        type: json['type'],
        url: json['url'],
        length: json['length'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'length': length,
      };
}

class Itunes {
  final String author;
  final String subtitle;
  final String summary;
  final String explicit;
  final String duration;
  final String image;

  Itunes({
    this.author,
    this.subtitle,
    this.summary,
    this.explicit,
    this.duration,
    this.image,
  });

  factory Itunes.fromJson(Map<String, dynamic> json) => new Itunes(
        author: json['author'],
        subtitle: json['subtitle'],
        summary: json['summary'],
        explicit: json['explicit'],
        duration: json['duration'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'subtitle': subtitle,
        'summary': summary,
        'explicit': explicit,
        'duration': duration,
        'image': image,
      };
}

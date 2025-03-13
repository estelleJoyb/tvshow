/*
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvshow/src/data/show.dart';
import 'package:tvshow/src/services/showService.dart';
import 'package:url_launcher/url_launcher_string.dart';
class TvShowDetailsScreen extends StatefulWidget {
  final int? showId;
  const TvShowDetailsScreen({super.key, this.showId});

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  Show? show;
  bool _isLoading = true;
  bool _isShowingDescription = false;

  void _fetchShow() async {
    ShowService.fetchShowById(widget.showId!).then((value) {
     setState(() {
       _isLoading = false;
       show = value;
     });
    });
  }

  @override
  void initState() {
    _fetchShow();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.showId == null) {
      return const Scaffold(body: Center(child: Text('Pas de show trouvés.')));
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
          _isLoading ? const Text("Show Details") :  Text(show!.name),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(show?.image_path != null)
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *0.5,
                      child: Image.network(show!.image_path)),
                ),
              if(show?.description != null)
                ExpansionTile(
                  title: const Text("Description",),
                  subtitle: _isShowingDescription ? null : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${show!.description?.substring(0, 100)}...'),
                  ),
                  onExpansionChanged: (value) {
                    setState(() {
                      _isShowingDescription = !_isShowingDescription;
                    });
                  },
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${show!.description}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],),

              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(show!.url ?? '' ,style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline,),
                  ),
                ),
                onTap: () => launchUrlString(show!.url ?? ''),
              ),

              if(show?.serieContent != null)
                const Text("Episodes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvshow/src/data/show.dart';
import 'package:tvshow/src/services/showService.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:intl/intl.dart';

class TvShowDetailsScreen extends StatefulWidget {
  final String? showId;
  const TvShowDetailsScreen({super.key, this.showId});

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  Show? show;
  bool _isLoading = true;
  bool _isShowingDescription = false;

  void _fetchShow() async {
    ShowService.fetchShow(widget.showId!).then((value) {
      setState(() {
        _isLoading = false;
        show = value;
      });
    });
  }

  @override
  void initState() {
    _fetchShow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showId == null) {
      return const Scaffold(body: Center(child: Text('Pas de show trouvés.')));
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            _isLoading ? const Text("Show Details") : Text(show!.name),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (show?.image_path != null)
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.network(show!.image_path)),
                ),
              if (show?.description != null)
                ExpansionTile(
                  title: const Text(
                    "Description",
                  ),
                  subtitle: _isShowingDescription
                      ? null
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${show!.description?.substring(0, 100)}...'),
                  ),
                  onExpansionChanged: (value) {
                    setState(() {
                      _isShowingDescription = !_isShowingDescription;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${show!.description}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),

              if (show!.serieContent.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Episodes",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              if (show!.serieContent.isNotEmpty)
                ...show!.serieContent.entries.map((entry) {
                  final seasonNumber = entry.key;
                  final episodes = entry.value;
                  return ExpansionTile(
                    title: Text('Season $seasonNumber'),
                    children: episodes.map((episode) {
                      return ListTile(
                        title: Text(episode.name),
                        subtitle: Text(
                            'Episode ${episode.episode}, Air Date: ${DateFormat('dd/MM/yyyy').format(episode.air_date)}'),
                      );
                    }).toList(),
                  );
                }).toList(),

              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    show!.url ?? '',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                onTap: () => launchUrlString(show!.url ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
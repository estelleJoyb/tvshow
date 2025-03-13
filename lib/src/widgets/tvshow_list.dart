import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvshow/src/data/show.dart';
import 'package:tvshow/src/services/showService.dart';

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  List<Show> _shows = [];
  bool _isLoading = false;
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchShows();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchShows() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      List<Show> shows = await ShowService.fetchShows(_page);
      setState(() {
        _shows = shows;
      });
    } catch (e) {
      print('Error fetching shows: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchNextPage() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      _page++;
      List<Show> newShows = await ShowService.fetchShows(_page);
      setState(() {
        _shows.addAll(newShows);
      });
    } catch (e) {
      print('Error fetching next page: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDetails(Show show) {
    context.go('/shows/${show.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV Shows')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _shows.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _shows.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final show = _shows[index];
          return ListTile(
            title: Text(show.name),
            subtitle: Text(show.country),
            onTap: () => _showDetails(show),
          );
        },
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvshow/src/data/show.dart';
import 'package:tvshow/src/services/showService.dart';

import '../widgets/tvshow_list.dart';

class TvShowResearch extends StatefulWidget {
  const TvShowResearch({super.key});

  @override
  _TvShowResearchState createState() => _TvShowResearchState();
}

class _TvShowResearchState extends State<TvShowResearch> {
  final TextEditingController searchTvShowController = TextEditingController();
  String searchWord = '';
  bool needRefresh = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV Shows')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Rechercher'),
                      SizedBox(
                        width: MediaQuery.of(context)!.size.width * 0.6,
                        child: TextField(controller: searchTvShowController, onChanged: (value) {
                          setState(() {
                            searchWord = value;
                          });
                        }, ),
                      ),
                    ],
                  ),
                 const  SizedBox(width: 8,),
                  ElevatedButton(
                    onPressed: () {
                     print('refresh');
                    },
                    child: Text("Rechercher"),
                  ),
                ],
              ),

              SizedBox(
                  height: MediaQuery.of(context)!.size.height * 0.75,
                  child: ShowList(searchWord: searchWord)),
            ],
          ),
        ),
      ),
    );

  }
}*/


import 'package:flutter/material.dart';
import 'package:tvshow/src/data/show.dart';
import 'package:tvshow/src/services/showService.dart';

import '../widgets/tvshow_list.dart';

class TvShowResearch extends StatefulWidget {
  const TvShowResearch({super.key});

  @override
  _TvShowResearchState createState() => _TvShowResearchState();
}

class _TvShowResearchState extends State<TvShowResearch> {
  final TextEditingController searchTvShowController = TextEditingController();
  String searchWord = '';
  bool needRefresh = false;

  void _refreshShows() {
    setState(() {
      needRefresh = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV Shows')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rechercher'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        controller: searchTvShowController,
                        onChanged: (value) {
                          setState(() {
                            searchWord = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: _refreshShows,
                  child: const Text("Rechercher"),
                ),
              ],
            ),
            Expanded(
              child: ShowList(
                searchWord: searchWord,
                needRefresh: needRefresh,
                onRefreshComplete: () {
                  setState(() {
                    needRefresh = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
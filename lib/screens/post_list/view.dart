
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knovator_gk_app/utils/routing/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/posts.dart';
import '../../data/network/api_service.dart';

part 'controller.dart';
part 'widget/timer_widget.dart';



class PostListScreen extends ConsumerStatefulWidget {


  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {

  Map<int, bool> _readPosts = {};
  Map<int, TimerWidget> _timers = {};


  void _markAsRead(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _readPosts[id] = true);
    await prefs.setStringList(
        'readPosts', _readPosts.keys.where((key) => _readPosts[key]!).map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(postListControllerProvider);
    final stateController = ref.watch(postListControllerProvider.notifier);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(title: Text('Posts')),
        body: FutureBuilder<List<Posts>>(
          future: state.postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final isRead = _readPosts[post.id] ?? false;

                if (_timers[post.id] == null) {
                  _timers[post.id ?? 0] = TimerWidget(initialDuration: [10, 20, 25][index % 3]);
                }

                return GestureDetector(
                  onTap: () {
                    _markAsRead(post.id ?? 0);
                    Navigator.pushNamed(context, RouteName.postDescriptionScreen,arguments: post.id);
                    //_timers[post.id]?.pauseTimer();
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8,left: 8,top: 8),
                        child: Container(
                          color: isRead ? Colors.white : Colors.yellow[100],
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(post.title ?? "",style: TextStyle(color: Colors.black),)),
                              _timers[post.id]!,
                            ],
                          ),

                        ),
                      ),
                      //SizedBox(height: 10,)
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

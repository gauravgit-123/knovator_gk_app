
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network/api_service.dart';
import 'controller.dart';


class PostDetailScreen extends ConsumerStatefulWidget {
  final int postId;

  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final params = VSControllerParams(postid: widget.postId);

    final state = ref.watch(postListControllerProvider(params));
    final stateController = ref.watch(postListControllerProvider(params).notifier);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Post Details')),
      body: FutureBuilder(
        future: state.postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final post = snapshot.data!;
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(post.body ?? "", style: TextStyle(color: Colors.black),),
            ),
          );
        },
      ),
    );
  }
}

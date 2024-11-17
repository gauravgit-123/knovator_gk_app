import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knovator_gk_app/data/network/api_service.dart';

import '../../model/posts.dart';

class VSControllerParams extends Equatable {
  final int postid;
  VSControllerParams(
      {
        required this.postid,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final _paramProvider = Provider<VSControllerParams>((ref) {
  throw UnimplementedError();
});


final postListControllerProvider = StateNotifierProvider.autoDispose.family<_VSController, _ViewState, VSControllerParams>((ref, params) {
  final stateController = _VSController(params);

  stateController.initState();

  return stateController;
});

class _ViewState {
  final Future<Posts>? postsFuture;

  _ViewState({required this.postsFuture});

  /// Initial state constructor
  _ViewState.init() : postsFuture = null;

  /// Method to copy the state with optional changes
  _ViewState copyWith({Future<Posts>? postsFuture}) {
    return _ViewState(
      postsFuture: postsFuture ?? this.postsFuture,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final VSControllerParams params;
  _VSController(this.params) : super(_ViewState.init());
  void initState() {
    fetchPostDetail();

  }


  Future<void> fetchPostDetail() async {
    try {
      Future<Posts>? posts = ApiService.fetchPostDetail(params.postid);
      state = state.copyWith(postsFuture: posts);
    } catch (e) {
      print("error in feting posts:$e");
    }
  }




  @override
  void dispose() {
    super.dispose();
  }
}
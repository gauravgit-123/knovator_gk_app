part of 'view.dart';

class _VSControllerParams extends Equatable {
  final int postid;
  _VSControllerParams(
      {
        required this.postid,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final _paramProvider = Provider<_VSControllerParams>((ref) {
  throw UnimplementedError();
});


final postListControllerProvider =
StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
  final stateController = _VSController();
  stateController.initState();
  return stateController;
});


class _ViewState {
  final Future<List<Posts>>? postsFuture;

  _ViewState({required this.postsFuture});

  /// Initial state constructor
  _ViewState.init() : postsFuture = null;

  /// Method to copy the state with optional changes
  _ViewState copyWith({Future<List<Posts>>? postsFuture}) {
    return _ViewState(
      postsFuture: postsFuture ?? this.postsFuture,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  //final _VSControllerParams params;
  _VSController() : super(_ViewState.init());
  void initState() {
    fetchPostList();
  }


  Future<void> fetchPostList() async {
   try {
   final posts = ApiService.fetchPosts();
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
part of 'view.dart';

final postListControllerProvider =
StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
  return _VSController();
});

class _ViewState {
  final List<Question> questions;
  final int currentIndex;

  _ViewState({
    required this.questions,
    required this.currentIndex,
  });

  factory _ViewState.init() => _ViewState(questions: [], currentIndex: 0);

  _ViewState copyWith({List<Question>? questions, int? currentIndex}) {
    return _ViewState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init()) {
    fetchPostDetail();
  }

  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previousQuestion() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }
  void updateSelectedAnswer(int questionIndex, String answer) {
    state = state.copyWith(
      questions: [
        for (int i = 0; i < state.questions.length; i++)
          if (i == questionIndex)
            state.questions[i]..selectedAnswer = answer
          else
            state.questions[i],
      ],
    );
  }
  String _mapAnswer(String? num) {
    switch (num) {
      case "1": return "A";
      case "2": return "B";
      case "3": return "C";
      case "4": return "D";
      case "5": return "E";
      default: return "";
    }
  }

  Future<void> fetchPostDetail() async {
    try {
      final response = await ApiService.fetchQuestions();
      state = state.copyWith(questions: response.questions);
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }
}

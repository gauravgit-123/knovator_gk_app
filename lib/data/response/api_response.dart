class ApiResponse {
  final List<Question> questions;
  final bool success;

  ApiResponse({required this.questions, required this.success});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var questionsList = json['questions'] as List;
    List<Question> questions =
    questionsList.map((i) => Question.fromJson(i)).toList();

    return ApiResponse(
      questions: questions,
      success: json['success'],
    );
  }
}

class Question {
  final String question;
  final String? option1;
  final String? option2;
  final String? option3;
  final String? option4;
  final String? option5;
  final String answer;
  final String explanation;
  String? selectedAnswer; // <-- make it mutable

  Question({
    required this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
    required this.answer,
    required this.explanation,
    this.selectedAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      option4: json['option4'],
      option5: json['option5'],
      answer: json['answer'],
      explanation: json['explanation'],
      selectedAnswer: null, // not selected yet
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'option5': option5,
      'answer': answer,
      'explanation': explanation,
      'selectedAnswer': selectedAnswer,
    };
  }
}

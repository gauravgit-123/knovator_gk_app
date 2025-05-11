import 'package:cracku_gk_app/screens/Questions/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network/api_service.dart';
import '../../data/response/api_response.dart';
import '../../model/apiResponse.dart';

part 'controller.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postListControllerProvider);
    final stateController = ref.watch(postListControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.white,), // Three horizontal lines (menu icon)
          onPressed: () {
            // Handle menu button press (e.g., open drawer)
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min, // Prevents taking full width
          children: [
            Text("Clipwise",style: TextStyle(color: Colors.white),),
            SizedBox(width: 8), // Space between text and image
            Image.asset(
              'assets/images/clipwise-icon.png', // Replace with your asset path
              height: 25, // Adjust size as needed
            ),
          ],
        ),
      ),
      body: state.questions.isEmpty
          ? Center(child: CircularProgressIndicator()) // Handle loading state
          : Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(), // Prevent swipe navigation
              itemCount: state.questions.length,
              itemBuilder: (context, index) {
                return _buildQuestionCard(state.questions[index],index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: state.currentIndex > 0
                        ? () {
                      stateController.previousQuestion();
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Slightly rounded corners
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12), // Button height
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text("« PREVIOUS"),
                  ),
                ),
                SizedBox(width: 8), // Space between buttons
                Expanded(
                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: state.currentIndex < state.questions.length - 1
                          ? () {
                        stateController.nextQuestion();
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                          : () {
                        // Navigate to Result Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              questions: state.questions,
                              // Add selectedAnswers if tracking
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: Text(
                        state.currentIndex < state.questions.length - 1 ? "NEXT »" : "SUBMIT",
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question, int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Question Card
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            elevation: 4,
            child: Stack(
              children: [
                // Question Label
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Question ${index + 1}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question ?? "No Question",
                        style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      _buildOption("A", question.option1 ?? "", index, "1"),
                      _buildOption("B", question.option2 ?? "", index, "2"),
                      _buildOption("C", question.option3 ?? "", index, "3"),
                      _buildOption("D", question.option4 ?? "", index, "4"),
                      if (question.option5 != null)
                        _buildOption("E", question.option5!, index, "5"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Solution Card
          // Card(
          //   color: Colors.white,
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          //   elevation: 4,
          //   child: Stack(
          //     children: [
          //       // Solution Label
          //       Positioned(
          //         top: 0,
          //         left: 0,
          //         child: Container(
          //           color: Colors.green,
          //           padding: const EdgeInsets.all(4.0),
          //           child: Text(
          //             "Solution:",
          //             style: TextStyle(
          //               fontSize: 11,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 16),
          //         child: Text(
          //           question.explanation ?? "No explanation provided",
          //           style: TextStyle(fontSize: 12, color: Colors.black87),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }


  Widget _buildOption(String label, String? option, int index, String optionNumber) {
    final stateController = ref.read(postListControllerProvider.notifier);
    final question = ref.read(postListControllerProvider).questions[index];
    final isSelected = question.selectedAnswer == optionNumber;
    //final isCorrect = question.answer == optionNumber;

    return GestureDetector(
      onTap: () {
        stateController.updateSelectedAnswer(index, optionNumber);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Colors.blue
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [

                 Text(
              "$label ",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                option ?? "",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }



}

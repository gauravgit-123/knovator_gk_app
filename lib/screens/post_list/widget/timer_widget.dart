part of '../view.dart';
class TimerWidget extends StatefulWidget {
  final int initialDuration;
  const TimerWidget({Key? key, required this.initialDuration}) : super(key: key);

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late int _duration;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _duration = widget.initialDuration;
    _startTimer();
  }

  void _startTimer() async {
    while (_isRunning && _duration > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (mounted && _isRunning) {
        setState(() {
          _duration--;
        });
      }
    }
  }

  void pauseTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void resumeTimer() {
    if (!_isRunning) {
      setState(() {
        _isRunning = true;
      });
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(postListControllerProvider);
    // final stateController = ref.watch(postListControllerProvider.notifier);

    return Text(
      '$_duration s',
      style: TextStyle(color: Colors.grey),
    );
  }
}

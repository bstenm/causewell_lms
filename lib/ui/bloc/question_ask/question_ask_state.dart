import 'package:causewell/data/models/QuestionAddResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuestionAskState {}

class InitialQuestionAskState extends QuestionAskState {}

class LoadedQuestionAskState extends QuestionAskState {
  LoadedQuestionAskState();
}

class QuestionAddedState extends QuestionAskState {
  final QuestionAddResponse questionAddResponse;
  QuestionAddedState(this.questionAddResponse);
}

class ErrorQuestionAskState extends QuestionAskState {}

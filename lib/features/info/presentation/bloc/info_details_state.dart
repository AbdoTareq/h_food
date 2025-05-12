import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InfoState extends Equatable {
  @override
  List<Object> get props => [];
}

class InfoEmpty extends InfoState {}

class InfoLoading extends InfoState {}

class InfoError extends InfoState {
  final String message;

  InfoError({required this.message});

  @override
  List<Object> get props => [message];
}

class InfoSuccess extends InfoState {
  final num calories;

  InfoSuccess({required this.calories});

  @override
  List<Object> get props => [calories];
}

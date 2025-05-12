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
  final bool success;

  InfoSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

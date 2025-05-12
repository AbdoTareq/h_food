import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveInfoEvent extends InfoEvent {
  final String weight;
  final String height;
  final String age;
  final String gender;

  SaveInfoEvent(
      {required this.weight,
      required this.height,
      required this.age,
      required this.gender});

  @override
  List<Object> get props => [age];
}

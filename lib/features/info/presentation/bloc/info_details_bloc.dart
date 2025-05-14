import 'package:h_food/export.dart';
import 'package:h_food/features/info/domain/usecases/info_usecase.dart';
import 'package:h_food/features/info/presentation/bloc/info_details_event.dart';
import 'package:h_food/features/info/presentation/bloc/info_details_state.dart';

class InfoDetailsBloc extends Bloc<InfoEvent, InfoState> {
  final SaveInfoUsecase infoUseCase;

  InfoDetailsBloc({
    required this.infoUseCase,
  }) : super(InfoEmpty()) {
    on<SaveInfoEvent>(_save);
  }

  Future<void> _save(SaveInfoEvent event, Emitter<InfoState> emit) async {
    emit(InfoLoading());
    final result = await infoUseCase(InfoParams(
        weight: event.weight.toDouble,
        height: event.height.toDouble,
        gender: event.gender,
        age: event.age.toDouble));
    result.fold(
      (failure) => emit(InfoError(message: failure.message)),
      (success) => emit(InfoSuccess(calories: success)),
    );
  }
}

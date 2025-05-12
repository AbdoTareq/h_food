import 'package:elm_task/export.dart';
import 'package:elm_task/features/info/domain/usecases/login_usecase.dart';
import 'package:elm_task/features/info/presentation/bloc/info_details_event.dart';
import 'package:elm_task/features/info/presentation/bloc/info_details_state.dart';

class InfoDetailsBloc extends Bloc<InfoEvent, InfoState> {
  final SaveInfoUsecase infoUseCase;

  InfoDetailsBloc({
    required this.infoUseCase,
  }) : super(InfoEmpty()) {
    on<SaveInfoEvent>(_save);
  }

  Future<void> _save(SaveInfoEvent event, Emitter<InfoState> emit) async {
    emit(InfoLoading());
    final result = await infoUseCase(LoginParams(email: event.age));
    result.fold(
      (failure) => emit(InfoError(message: failure.message)),
      (success) => emit(InfoSuccess(success: success)),
    );
  }
}

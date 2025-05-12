import 'package:elm_task/export.dart';
import 'package:elm_task/features/info/domain/usecases/login_usecase.dart';
import 'package:elm_task/features/info/domain/usecases/verify_usecase.dart';
import 'package:elm_task/features/info/presentation/bloc/auth_event.dart';
import 'package:elm_task/features/info/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUseCase;
  final VerifyUsecase verifyUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.verifyUseCase,
  }) : super(AuthEmpty()) {
    on<LoginEvent>(_login);
    on<VerifyEvent>(_verify);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(email: event.email));
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) => emit(LoginSuccess(success: success)),
    );
  }

  Future<void> _verify(VerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result =
        await verifyUseCase(VerifyParams(email: event.email, otp: event.otp));
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) => emit(VerifySuccess(success: success)),
    );
  }
}

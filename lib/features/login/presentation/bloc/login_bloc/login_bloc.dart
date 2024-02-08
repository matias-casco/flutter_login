import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/features/login/data/models/models.dart';
import 'package:flutter_login/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter_login/features/login/presentation/validations/validations.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginUsecase,
  }) : super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LogoutEvent>(_onLogout);

    print('inputs escuchando');
  }

  final LoginUseCase loginUsecase;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    print(state.isValid);
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final loginResult = await loginUsecase(
        User(
          username: state.username.value,
          password: state.password.value,
          id: '',
        ),
      );

      loginResult.fold((error) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }, (success) {
        emit(
          state.copyWith(
            username: const Username.pure(),
            password: const Password.pure(),
            status: FormzSubmissionStatus.success,
            isValid: false,
          ),
        );
      });
    }
  }

  void _onLogout(
    LogoutEvent event,
    Emitter<LoginState> emit,
  ) {
    print('logout event');
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        isValid: false,
      ),
    );
  }
}

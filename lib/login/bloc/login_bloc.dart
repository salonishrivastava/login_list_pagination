import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(InitialState()){
      on<OnButtonClickEvent>((event,emit) async {
emit(LoadingState());
await Future.delayed(Duration(seconds: 4));
emit(LoginSuccess());
      });
    }
  }



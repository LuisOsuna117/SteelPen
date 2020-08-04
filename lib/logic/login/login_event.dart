part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLoginEvent extends LoginEvent{
  final String user;
  final String password;

  DoLoginEvent(this.user,this.password);

  @override
  // TODO: implement props
  List<Object> get props => [user, password];
}
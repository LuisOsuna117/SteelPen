part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class LoadingUsers extends UserState{
  @override
  List<Object> get props => [];

}

class LoadedUsers extends UserState{
  final List<User> list;
  LoadedUsers({this.list});
  @override
  List<Object> get props => [list];

}

class ErrorState extends UserState{
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
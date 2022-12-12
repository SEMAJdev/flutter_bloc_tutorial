part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final UserModel userModel;

  const UsersLoaded(this.userModel);

  @override
  List<Object?> get props => [userModel];
}

class UsersError extends UsersState {
  final String? errorMessage;

  const UsersError(this.errorMessage);
}

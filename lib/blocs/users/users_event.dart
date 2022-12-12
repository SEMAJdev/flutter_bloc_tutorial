part of 'users_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetUsersList extends UsersEvent {
  final List<User> users;

  const GetUsersList({this.users = const <User>[]});

  @override
  // TODO: implement props
  List<Object> get props => [users];
}

class AddUsers extends UsersEvent {
  final User user;

  const AddUsers({required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class UpdateUsers extends UsersEvent {
  final User user;
  final int index;

  const UpdateUsers({required this.user, required this.index});

  @override
  // TODO: implement props
  List<Object> get props => [user, index];
}

class DeleteUsers extends UsersEvent {
  final User user;

  const DeleteUsers({required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

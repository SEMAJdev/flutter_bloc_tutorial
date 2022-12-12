import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/users_model.dart';
import '../../repository/api_repository.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersLoading()) {
    on<GetUsersList>(_onGetUsers);
    on<AddUsers>(_onAddUsers);
    on<UpdateUsers>(_onUpdateUsers);
    on<DeleteUsers>(_onDeleteUsers);
  }

  void _onGetUsers(GetUsersList event, Emitter<UsersState> emit) async {
    print("UsersBloc GetUsersList");
    final ApiRepository apiRepository = ApiRepository();
    try {
      emit(UsersLoading());
      final userList = await apiRepository.fetchUserList();
      emit(UsersLoaded(userList));
      if (userList.users.isEmpty) {
        print("UsersBloc GetUsersList FAILED.");
        emit(const UsersError("Something went wrong!"));
      } else {
        print("UsersBloc GetUsersList SUCCESS.");
      }
    } on NetworkError {
      print("UsersBloc GetUsersList NetworkError.");
      emit(const UsersError("Failed to fetch data. is your device online?"));
    }
  }

  void _onAddUsers(AddUsers event, Emitter<UsersState> emit) {
    final state = this.state;
    print("UsersBloc _onAddUsers ${event.user.id}");
    if (state is UsersLoaded) {
      print("UsersBloc _onAddUsers is UsersLoaded");
      emit(UsersLoaded(UserModel(users: List.from(state.userModel.users)..add(event.user))));
    }
  }

  void _onUpdateUsers(UpdateUsers event, Emitter<UsersState> emit) {
    final state = this.state;
    print("UsersBloc _onDeleteUsers ${event.index}");
    if (state is UsersLoaded) {
      print("UsersBloc _onAddUsers is UsersLoaded");

      state.userModel.users[event.index] = event.user;

      /// find UserBloc index for update value
      List<User> userList = state.userModel.users
        ..asMap().forEach((key, value) {
          if (key == event.index) {
            state.userModel.users[key] = event.user;
          }
        });

      emit(UsersLoaded(UserModel(users: userList)));
    }
  }

  void _onDeleteUsers(DeleteUsers event, Emitter<UsersState> emit) {
    final state = this.state;
    print("UsersBloc _onDeleteUsers ${event.user.id}");
    if (state is UsersLoaded) {
      print("UsersBloc _onAddUsers is UsersLoaded");
      emit(UsersLoaded(UserModel(
          users: List.from(state.userModel.users)
            ..removeWhere(
              (element) => element.id == event.user.id && element.email == event.user.email,
            ))));
    }
  }
}

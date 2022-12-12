import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/blocs/users/users_bloc.dart';
import 'package:flutter_bloc_tutorial/models/users_model.dart';
import 'package:flutter_bloc_tutorial/screens/add_users_screen.dart';
import 'package:flutter_bloc_tutorial/screens/update_users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final UsersBloc _usersBloc = UsersBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UsersBloc>().add(const GetUsersList());
    // ().add();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: Users'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUserScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
              ),
            );
          }
        },
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UsersLoaded) {
              return ListView.builder(
                itemCount: state.userModel.users.length,
                itemBuilder: (context, index) {
                  return _userCard(state.userModel.users[index], index);
                },
              );
            } else if (state is UsersError) {
              return Center(
                child: Text(state.errorMessage!),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Card _userCard(User user, int index) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateUserScreen(user: user, index: index),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('id: ${user.id}'),
                    Text('username: ${user.username}'),
                    Text('name: ${user.firstName}'),
                    Text('email: ${user.email}'),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  var userRemove = User(
                      id: user.id,
                      firstName: user.firstName,
                      email: user.email,
                      username: user.username);

                  context.read<UsersBloc>().add(DeleteUsers(user: userRemove));
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Delete user success."),
                    ),
                  );
                },
                splashRadius: 20,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: Icon(Icons.clear, color: Colors.redAccent.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

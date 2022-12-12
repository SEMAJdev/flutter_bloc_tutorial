import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/blocs/users/users_bloc.dart';
import 'package:flutter_bloc_tutorial/models/users_model.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerId.dispose();
    controllerUsername.dispose();
    controllerName.dispose();
    controllerEmail.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BloC Pattern: Add a User'),
        ),
        body: BlocListener<UsersBloc, UsersState>(
          listener: (context, state) {
            if (state is UsersLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("User Added!"),
                ),
              );
            }
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerId,
                      decoration: const InputDecoration(
                        labelText: "ID",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controllerUsername,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        } else if (value.length < 4) {
                          return "Username should be at least 4 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controllerName,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controllerEmail,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        } else if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value)) {
                          return 'Email is not valid';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bool validate = _formKey.currentState!.validate();
                        if (validate) {
                          debugPrint("Name : ${controllerName.text}");
                          debugPrint("Email : ${controllerEmail.text}");

                          var user = User(id: int.parse(controllerId.text),
                              firstName: controllerName.text,
                              email: controllerEmail.text,
                              username: controllerUsername.text);

                          context.read<UsersBloc>().add(
                            AddUsers(user: user)
                          );
                          Navigator.pop(context);
                          // var count = state.users.;
                          // debugPrint("count : ${count}");
                          // var user = User(id: id, name: name, username: username, email: email);
                        }
                      },
                      child: const Text("Add User"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

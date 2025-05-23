import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_event.dart';
import 'package:go_router/go_router.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return  Center(child: ElevatedButton.icon(onPressed: (){
      authBloc.add(GoogleOutEvent());
      context.go("/auth");
      //Navigator.pushReplacementNamed(context, "/AuthScreen");
    }, label: Text("Sign Out")),);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_event.dart';
import 'package:flutterbloc/src/blocs/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  @override
  Widget build(BuildContext context) {
  final authBloc = context.read<AuthBloc>();
    return BlocConsumer<AuthBloc , AuthState>(builder: 
    (context , state){
      if ( state is GoogleSignInLoding){
        return Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        body: Center(
          child: ElevatedButton.icon(onPressed: (){
            print("clicked");
            authBloc.add(GoogleSignInEvent());
          }, label: Text('Google Sign In'),
      
         ),
        ),
      );
    }
    
    , listener: (BuildContext context, AuthState state) { 
      if(state is GoogleSignInLoded){
        context.go("/home");
      }

      if(state is AuthError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Not sign in")));
      }
     },);
  }
}
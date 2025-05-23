import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc_event.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc_state.dart';
import 'package:flutterbloc/src/blocs/auth/auth_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_state.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({super.key});

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  @override
  
    Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    //final authBloc = context.read<AuthBloc>();
    return BlocBuilder<HomeBloc,HomeBlocState>(builder: (context ,state) {
    final authState = context.watch<AuthBloc>().state;
      String username = "Guest";
      if(authState is GoogleSignInLoded){
        username = authState.username;
      }
      return Scaffold(
        appBar: AppBar(title: Text("Welcome ${username}"),),
        body: bloc.pages[state.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (index ) {
              bloc.add(SelectIndexEvent(index));
          },

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
                BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
                
          ]
          
          ),
      );
    });
  }
}
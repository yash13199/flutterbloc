import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_bloc.dart';
import 'package:flutterbloc/src/blocs/dashboard/dash_bloc.dart';


final providers = [
    BlocProvider<DashboardBloc>(create: (BuildContext context) => DashboardBloc()),
    BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
    BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
  ];

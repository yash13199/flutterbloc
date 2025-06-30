import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_bloc.dart';
import 'package:flutterbloc/src/blocs/dashboard/dash_bloc.dart';
import 'package:flutterbloc/src/blocs/feed/feed_bloc.dart';
import 'package:flutterbloc/src/blocs/uploadpost/uploadpost_bloc.dart';


final providers = [
    BlocProvider<DashboardBloc>(create: (BuildContext context) => DashboardBloc()),
    BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
    BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
    BlocProvider<UploadpostBloc>(create: (BuildContext context) => UploadpostBloc()),
        BlocProvider<FeedBloc>(create: (BuildContext context) => FeedBloc()),


  ];

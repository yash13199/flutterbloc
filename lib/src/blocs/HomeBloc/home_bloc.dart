import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc_event.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc_state.dart';
import 'package:flutterbloc/src/screen/accountscreen/accountScreen.dart';
import 'package:flutterbloc/src/screen/dashboardScreen/dashboardscreen.dart';
import 'package:flutterbloc/src/screen/feedScreen/feedScreen.dart';
import 'package:flutterbloc/src/screen/mapscreen/mapscreen.dart';
import 'package:flutterbloc/src/screen/uploadScreen/uploadScreen.dart';


class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {

  List pages = [   Dashboardscreen(),
    Accountscreen(),
    Feedscreen(),
    Uploadscreen(),
    ChooseRoleScreen(),
    ];

  HomeBloc() : super(HomeBlocState(0)) {
    on<SelectIndexEvent>((event, emit) {
      emit(HomeBlocState(event.currentIndex));
    });

    
  }
}

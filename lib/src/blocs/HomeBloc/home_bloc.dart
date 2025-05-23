import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc_event.dart';
import 'package:flutterbloc/src/blocs/HomeBloc/home_bloc_state.dart';
import 'package:flutterbloc/src/screen/accountscreen/accountScreen.dart';
import 'package:flutterbloc/src/screen/dashboardScreen/dashboardscreen.dart';
import 'package:flutterbloc/src/screen/mapscreen/mapscreen.dart';


class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {

  List pages = [   Dashboardscreen(),
    Accountscreen(),
    Mapscreen()
    
    ];

  HomeBloc() : super(HomeBlocState(0)) {
    on<SelectIndexEvent>((event, emit) {
      emit(HomeBlocState(event.currentIndex));
    });

    
  }
}

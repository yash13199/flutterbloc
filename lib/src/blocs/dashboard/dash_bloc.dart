import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/dashboard/dash_bloc_event.dart';
import 'package:flutterbloc/src/blocs/dashboard/dash_bloc_state.dart';
import 'package:flutterbloc/src/blocs/dashboard/productModel.dart';
import 'package:http/http.dart' as http;


class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProductsEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());


    try{
      final url = Uri.parse("https://fakestoreapi.com/products");

      final response = await http.get(url);

      if(response.statusCode == 200){
        //final PrdocutModel data = PrdocutModel.fromJson(jsonDecode(response.body) as List).map()
        final List<PrdocutModel> products = (jsonDecode(response.body) as List)
    .map((json) => PrdocutModel.fromJson(json))
    .toList();
        emit(DashboardLoaded(products));
      }else{
        emit(DashboardError('Error is  ${response.statusCode.toString()}'));
      }
    }catch(e){
        emit(DashboardError('${e}'));
    }
  }
}

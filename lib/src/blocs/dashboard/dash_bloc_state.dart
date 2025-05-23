import 'package:flutterbloc/src/blocs/dashboard/productModel.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<PrdocutModel> products;
  DashboardLoaded(this.products);
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/dashboard/dash_bloc.dart';
import 'package:flutterbloc/src/blocs/dashboard/dash_bloc_event.dart';
import 'package:flutterbloc/src/blocs/dashboard/dash_bloc_state.dart';


class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DashboardBloc>().add(FetchProductsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              //final product = state.products[index];
              return ListTile(
                leading: Image.network(
                  state.products[index].image,
                  height: 40,
                  width: 40,
                ),
                title: Text(state.products[index].title),
                subtitle: Text(state.products[index].price.toString()),
              );
            },
          );
        } else if (state is DashboardError) {
          return Center(child: Text(state.message));
        }
    
        return const Center(child: Text('Welcome to Dashboard'));
      }, listener: (BuildContext context, DashboardState state) { 
        
       },
    );
  }
}

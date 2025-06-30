import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/feed/feed_bloc.dart';
import 'package:flutterbloc/src/blocs/feed/feed_event_bloc.dart';
import 'package:flutterbloc/src/blocs/feed/feed_state_bloc.dart';

class Feedscreen extends StatefulWidget {
  const Feedscreen({super.key});

  @override
  State<Feedscreen> createState() => _FeedscreenState();
}

class _FeedscreenState extends State<Feedscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FeedBloc>().add(FetchFeedDataEvent());
    //
  }
  @override
  Widget build(BuildContext context) {
    final feed_bloc = context.read<FeedBloc>();
    return BlocConsumer<FeedBloc , FeedStateBloc>(builder: (context , state ) {
      if ( state is FeedStateEmpty){
        return Center(
          child: Text("No Data Found"),
        );
      }
        else if ( state is FeedStateLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          return ListView.builder(itemCount: feed_bloc.feeds.length ,itemBuilder: (context , index){
              return ListTile(
                leading: Image.network(feed_bloc.feeds[index].imageUrl),
                title: Text(feed_bloc.feeds[index].name),
                subtitle: Text(feed_bloc.feeds[index].location),
              );
          });
        }
    }, listener: (BuildContext context, Object? state) {
              if (state is FeedStateLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Feeds loaded successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        }
                if (state is FeedStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to load feeds: ${state.error}"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    
  }
}
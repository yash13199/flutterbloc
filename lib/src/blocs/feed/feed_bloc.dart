
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/feed/feed_event_bloc.dart';
import 'package:flutterbloc/src/blocs/feed/feed_model.dart';
import 'package:flutterbloc/src/blocs/feed/feed_state_bloc.dart';

class FeedBloc extends Bloc<FeedEventBloc , FeedStateBloc>{
  
  List<FeedModel> feeds = [];

  FeedBloc() : super(FeedStateEmpty()){

    on<FetchFeedDataEvent>((event, emit) async{
      emit(FeedStateLoading());
      await _handleFetchDataEvent(event , emit);
    });
  }

  Future<void> _handleFetchDataEvent(FeedEventBloc event , Emitter<FeedStateBloc> emit)async {
    try{
      final res = await FirebaseFirestore.instance.collection('posts').get();
      feeds = res.docs.map((doc) => FeedModel.fromJson(doc.data())).toList();
      emit(FeedStateLoaded(feeds));
    }catch(error){
      emit(FeedStateError(error.toString()));
    }

  }

}
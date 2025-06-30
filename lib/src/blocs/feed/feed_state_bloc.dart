import 'package:flutterbloc/src/blocs/feed/feed_model.dart';

abstract class FeedStateBloc {}

class FeedStateEmpty extends FeedStateBloc{}

class FeedStateLoading extends FeedStateBloc{}

class FeedStateLoaded extends FeedStateBloc{
  List<FeedModel>? feeds;
  
  FeedStateLoaded(this.feeds);
  }

class FeedStateError extends FeedStateBloc{
  String? error;

  FeedStateError(this.error);
}
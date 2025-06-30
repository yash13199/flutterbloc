
abstract class UploadEventBloc {}

class UploadPostEvent extends UploadEventBloc{
  String? name;
  String? location;
  UploadPostEvent({this.name , this.location});
}

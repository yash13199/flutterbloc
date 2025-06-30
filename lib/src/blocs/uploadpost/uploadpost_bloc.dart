import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/uploadpost/upload_event_bloc.dart';
import 'package:flutterbloc/src/blocs/uploadpost/upload_state_bloc.dart';

class UploadpostBloc extends Bloc<UploadEventBloc , UploadStateBloc>{

  UploadpostBloc() :super(Uploadinitial()) {

    on<UploadPostEvent>((event, emit) async  {
      await _uploadPostHandle(event , emit);
    });
  }

  Future<void> _uploadPostHandle(UploadPostEvent event , Emitter<UploadStateBloc> emit) async{
    
    try{
  print(event.location);
  print(event.name);
    await FirebaseFirestore.instance.collection('posts').add({
      'location':event.location,
      'name' : event.name,
      'imageUrl' : 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/2560px-Image_created_with_a_mobile_phone.png'

  });
    }catch(error){
      print(error);
    }
  }


    
  
}
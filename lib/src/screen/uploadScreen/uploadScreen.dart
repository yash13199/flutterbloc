import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/uploadpost/upload_event_bloc.dart';
import 'package:flutterbloc/src/blocs/uploadpost/upload_state_bloc.dart';
import 'package:flutterbloc/src/blocs/uploadpost/uploadpost_bloc.dart';

class Uploadscreen extends StatefulWidget {
  const Uploadscreen({super.key});

  @override
  State<Uploadscreen> createState() => _UploadscreenState();
}

class _UploadscreenState extends State<Uploadscreen> {
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();

  @override
  Widget build(BuildContext context) {
  final upload_bloc = context.read<UploadpostBloc>();
    return BlocBuilder<UploadpostBloc , UploadStateBloc>(
      builder: (context , state) {
         return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  TextField(
                    controller: location,
                    decoration: InputDecoration(
        hintText: 'Enter Location', // <-- this is the placeholder
        border: OutlineInputBorder(), // optional: adds border
          )
                  ),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
        hintText: 'Enter Name', // <-- this is the placeholder
        border: OutlineInputBorder(), // optional: adds border
          )
                  ),
                  
        
                ElevatedButton.icon(onPressed: (){
                  upload_bloc.add(UploadPostEvent(
                    location: location.text,
                    name: name.text
                  ));
                }, label: Text("Add Data"),
                icon: Icon(Icons.add), )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
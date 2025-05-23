import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/src/blocs/auth/auth_event.dart';
import 'package:flutterbloc/src/blocs/auth/auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(GoogleSignInInital()) {
    on<GoogleSignInEvent>((event, emit) async {
      print("in auth bloc handle");
      await _handleGoogleSignIn(event, emit);
    });

    on<GoogleOutEvent>((event, emit) async {
      await _signOuthandle();
      emit(GoogleSignInInital());
    });
  }

  Future<void> _handleGoogleSignIn(AuthEvent event, Emitter<AuthState> emit) async {
    try {
      print("in google bloc");

      final googleUser = await _googleSignIn.signIn();  // <-- FIXED

      if (googleUser == null) {
        emit(AuthError("User cancelled sign-in or sign-in failed"));
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await _auth.signInWithCredential(credential);
      emit(GoogleSignInLoded(_auth.currentUser?.displayName ?? "Unknown User"));
    } catch (e) {
      emit(AuthError("Sign-in failed: ${e.toString()}"));
    }
  }

  Future<void> _signOuthandle() async {
    await _auth.signOut();
    await _googleSignIn.signOut().then((val){
      final user = FirebaseAuth.instance.currentUser;
      print(user);

    });

  }
}

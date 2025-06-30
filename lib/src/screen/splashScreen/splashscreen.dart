import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _scale = 0.8;




  @override
  void initState() {
    super.initState();

    // Start animation after short delay
    //final authBloc = context.read<AuthBloc>();
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_){
   //final authState = context.read<AuthBloc>().state;
    final user = FirebaseAuth.instance.currentUser;

      Timer(const Duration(seconds: 3), () {
      if(user != null){
        context.go('/home');
      }else{
        context.push('/auth');
      
      }
    });
    });
  
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 2),
            curve: Curves.easeOutBack,
            child: const Text(
              'MyApp',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:coding_diary/src/constants/typography.dart';
import 'package:coding_diary/src/services/auth_service.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {

  final AuthService auth = AuthService();
        
    return Scaffold(
      body: FutureBuilder(
        future: auth.getUsername(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final username = snapshot.data;
            return Center(
            child: Text('Hello $username Welcome to the Home Screen', style: TypographyDMMono.displayMedium,),
          );
          }
          return Text('Sorry no username fetched');        
        }
      ),
    );
  }
}
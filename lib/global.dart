import 'package:firebase_auth/firebase_auth.dart';

bool? isIntroScreenOpened;
int? isviewed;

String? fullName = FirebaseAuth.instance.currentUser!.displayName;
String? profilepic = FirebaseAuth.instance.currentUser!.photoURL;


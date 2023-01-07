import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:software_engg_project/src/features/authentication/screens/login/login_screen.dart';
import 'package:software_engg_project/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:software_engg_project/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';

import '';
import '../../features/authentication/screens/on_boarding/on_boarding_screen.dart';

class AuthenticationRepository extends GetxController {



  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => WelcomeScreen())
        : Get.offAll(() => Dashboard());
  }

  //Func
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again');
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => Dashboard())
          : Get.to(() => WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar('Error', 'FIREBASE AUTH EXCEPTION - ${ex.message}');
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar('Error','EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      firebaseUser.value != null
          ? Get.offAll(() => Dashboard())
          : Get.to(() => WelcomeScreen());

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Error - ${e}" );
    }
  }



  logout()  async {

    final GoogleSignIn googleSignIn = GoogleSignIn();

    await _auth.signOut();
    await googleSignIn.signOut();
  }


  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }


}

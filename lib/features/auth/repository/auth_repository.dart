import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/respository/common_cloudinary_repository.dart';
import 'package:myapp/common/utils/utils.dart';
import 'package:myapp/features/auth/screens/otp_screen.dart';
import 'package:myapp/features/auth/screens/user_info_screen.dart';
import 'package:myapp/info.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/mobile_layout_screen.dart';
import 'package:riverpod/riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      // showSnackBar(context: context, content: "Verifying please wait");
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackBar(context: context, content: e.message!);
          throw Exception(e.message);
        },
        codeSent: (String verficationId, int? resendToken) async {
          showSnackBar(context: context, content: "Sending token wait");
          Navigator.pushNamed(
            context,
            OtpScreen.routeName,
            arguments: verficationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInfoScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserData({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = emptyAvatarUrl;

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonCloudinaryRepositoryProvider)
            .storeFileToCloudinary('profilePic/$uid', profilePic);
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        groupId: [],
        phoneNumber: auth.currentUser!.phoneNumber!,
      );

      await firestore.collection("users").doc(uid).set(user.toJson());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MobileLayoutScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}

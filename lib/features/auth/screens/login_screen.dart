import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/colors.dart';
import 'package:myapp/common/utils/utils.dart';
import 'package:myapp/common/widgets/custom_button.dart';
import 'package:myapp/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = "/login-screen";

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();

  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country localCountry) {
        setState(() {
          country = localCountry;
        });
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();

    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControlleProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: "Fill all the feilds");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("WhatsApp will need to verify your phone number."),
            const SizedBox(height: 10),
            TextButton(onPressed: pickCountry, child: Text("Pick Country")),
            const SizedBox(height: 5),
            Row(
              children: [
                if (country != null) Text("+${country!.phoneCode}"),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(hintText: "Phone Number"),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.55),
            SizedBox(
              width: 90,
              child: CustomButton(onPressed: sendPhoneNumber, text: "NEXT"),
            ),
          ],
        ),
      ),
    );
  }
}

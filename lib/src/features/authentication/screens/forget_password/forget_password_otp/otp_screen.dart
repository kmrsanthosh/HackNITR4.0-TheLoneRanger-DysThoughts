import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:software_engg_project/src/constants/sizes.dart';
import 'package:software_engg_project/src/constants/text_strings.dart';
import 'package:software_engg_project/src/features/authentication/controllers/login_controller.dart';

import '../../../controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget{
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var otp;

    Get.put(OTPController());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tOtpTitle, style: GoogleFonts.montserrat(
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),),
            Text(tOtpSubTitle.toUpperCase(), style: Theme.of(context).textTheme.headline6,),
            const SizedBox(height: 40,),
            Text("$tOtpMessage support@support.com", textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              keyboardType: TextInputType.number,
              onSubmit: (code) {
                otp = code;
                OTPController.instance.verifyOTP(otp);
                },
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
                child: ElevatedButton(onPressed: () {OTPController.instance.verifyOTP(otp);}, child: Text(tNext),))
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/colors.dart';
import 'package:nafith_dashboard/shared/components/components.dart';

class AdminLogin extends StatelessWidget {
  var codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("لوحة التحكم",style: TextStyle(fontSize: 28,color: buttonsColor),),
                ],
              ),
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child: Container(
                   height: 350,
                     width: double.infinity,
                     child: Image.asset("assets/images/securityOn.png"
                     )
                 ),
               )
             ],
           ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: defaultTxtForm(
                  controller: codeController,
                  type: TextInputType.text,
                  validate: (val){

                  },
                  label: "كود المسؤول",
                prefix: Icons.admin_panel_settings

              ),
            ),
            SizedBox(height: 25,),
            defaultButton(function: (){
              AdminCubit.get(context).checkAdmin(codeController.text, context);
            }, text: "ابدأ")

          ],
        ),
      ),

    );
  }
}

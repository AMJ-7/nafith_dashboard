import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/colors.dart';
import 'package:nafith_dashboard/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var adminController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context,state)=> {},
      builder:(context,state)=> Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("أضف كود مدير",style: TextStyle(fontSize: 22,color: Colors.teal),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: defaultTxtForm(
                  controller: adminController,
                  type: TextInputType.text,
                  validate: (val){

                  },
                  label: "الكود",
                  prefix: Icons.code
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: defaultButton(function: (){
                AdminCubit.get(context).addCode(adminController.text);
                adminController.text = "";
                showToast(text: "تمت الاضافة بنجاح", state: ToastStates.SUCCESS);
              },
                  text: "اضافة الكود"
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الاكواد المتوفرة",style: TextStyle(fontSize: 22,color: Colors.teal),),
                ],
              ),
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context , index) => buildCodeItem(AdminCubit.get(context).codes[index], context),
                separatorBuilder: (context , index) => SizedBox(height: 5,),
                itemCount: AdminCubit.get(context).codes.length
            )

          ],
        ),
      ),
    );
  }
}
Widget buildCodeItem(String Code, context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                Text(Code,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: buttonsColor),)
              ],
            ),
            Spacer(),
            IconButton(
              icon : Icon(CupertinoIcons.delete,color: Colors.red,size: 25),
              onPressed: (){
                AdminCubit.get(context).deleteCodes(Code);
              },

            )

          ],
        ),
      ),
    ),
  );
}


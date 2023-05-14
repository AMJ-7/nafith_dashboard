import 'package:flutter/material.dart';
import 'package:nafith_dashboard/models/message_model.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/colors.dart';
import 'package:nafith_dashboard/shared/components/components.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.separated(
          itemBuilder:(context, index) =>  buildMessageItem(AdminCubit.get(context).messages[index]),
          separatorBuilder: (context, index) => SizedBox(height: 15,),
          itemCount: AdminCubit.get(context).messages.length
      ),
    );
  }
}
Widget buildMessageItem(MessageModel model){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.person_outline,color: Colors.teal,),
                SizedBox(width: 5,),
                Text(model.sender,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: buttonsColor)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.email_outlined,color: Colors.teal,),
                SizedBox(width: 5,),
                Text(model.email,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.grey),),
              ],
            ),
            myDivider(),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(maxLines: 5,"${model.content}"),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

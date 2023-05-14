import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:nafith_dashboard/models/payment_model.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/components/components.dart';

class StudentPays extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معاملاته"),
      ),
      body: ConditionalBuilder(
        condition: AdminCubit.get(context).userPayments.length > 0,
        builder:(context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (context, index) => buildUserPaymentsItem(AdminCubit.get(context).userPayments[index],context) ,
            separatorBuilder: (context, index) => myDivider(),
            itemCount: AdminCubit.get(context).userPayments.length ,
          ),
        ),
        fallback: (context) => Center(child: Text("لم يجري هذا المستخدم معاملات")),
      ),

    );
  }
}

buildUserPaymentsItem(PaymentModel model, context){
  return Card(
    color: Colors.teal.withOpacity(0.5),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("المدفوع : ${model.amount}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              Text("التاريخ : ${model.dateTime}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ],
          ),
          SizedBox(width: 15,),
          Icon(Icons.monetization_on_outlined,color: Colors.white,),
        ],
      ),
    ),
  );
}

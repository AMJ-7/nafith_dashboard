import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/colors.dart';
import 'package:nafith_dashboard/shared/components/components.dart';

class EarningScreen extends StatelessWidget {
  var couponController = TextEditingController();
  var disController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) => {},
      builder:(context, state) => SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("اجمالي الارباح",style: TextStyle(color: Colors.grey[600],fontSize: 20),),
                            Text("${AdminCubit.get(context).total}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: buttonsColor),)
                          ],
                        ),
                        Spacer(),
                        Icon(CupertinoIcons.money_dollar_circle,color: Colors.teal,size: 50,)

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("أرباح اليوم",style: TextStyle(color: Colors.grey[600],fontSize: 20),),
                            Text("${AdminCubit.get(context).today}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: buttonsColor),)
                          ],
                        ),
                        Spacer(),
                        Icon(CupertinoIcons.money_dollar,color: Colors.teal,size: 50,)

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("أضافة كوبون",style: TextStyle(color: buttonsColor,fontSize: 24),),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: defaultTxtForm(
                          controller: couponController,
                          type: TextInputType.text,
                          validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }
                          },
                          label: "كوبون",
                          prefix: Icons.code
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: defaultTxtForm(
                          controller: disController,
                          type: TextInputType.number,
                          validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }

                          },
                          label: "النسبة %",
                          prefix: Icons.percent
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: defaultButton(function: (){
                  if(formKey.currentState!.validate()){
                    AdminCubit.get(context).addCoupon(couponController.text,disController.text);
                    couponController.text = "";
                    disController.text = "";
                    showToast(text: "تمت الاضافة بنجاح", state: ToastStates.SUCCESS);
                  }

                }, text: "اضافة الكوبون"),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("الكوبونات",style: TextStyle(color: buttonsColor,fontSize: 24),),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context , index) => buildCouponItem(AdminCubit.get(context).coupons[index], context),
                  separatorBuilder: (context , index) => SizedBox(height: 5,),
                  itemCount: AdminCubit.get(context).coupons.length
              )

            ],
          ),
        ),
      ),
    );
  }
  Widget buildCouponItem(String coupon, context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text(coupon,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: buttonsColor),)
                ],
              ),
              Spacer(),
              IconButton(
                  icon : Icon(CupertinoIcons.delete,color: Colors.red,size: 25),
                  onPressed: (){
                    AdminCubit.get(context).deleteCoupon(coupon);

                  },

              )

            ],
          ),
        ),
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafith_dashboard/models/userModel.dart';
import 'package:nafith_dashboard/modules/reservation/reservation_screen.dart';
import 'package:nafith_dashboard/modules/students_screen/student_pays.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/colors.dart';
import 'package:nafith_dashboard/shared/components/components.dart';

class EditStudent extends StatelessWidget {
  UserModel model ;
  EditStudent(this.model);

  var bioController = TextEditingController() ;
  var emailController = TextEditingController() ;
  var nameController = TextEditingController() ;
  var phoneController = TextEditingController() ;



  @override
  Widget build(BuildContext context) {
    bioController.text = model.bio;
    emailController.text = model.email;
    nameController.text = model.name;
    phoneController.text = model.phone;
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state){
        if(state is AdmingetPaymentsSuccessState){
          navigateTo(context, StudentPays());
        }

        if(state is AdminGetReservedSuccessState){
          navigateTo(context, ReservationScreen(model));
        }
      },
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: Text(model.name),
            actions: [
              if(model.type == "teacher")
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.star , color: Colors.amber,),
                    model.rate == null ? Text("0.0", style: TextStyle(fontSize: 18,color: Colors.black),)
                        : Text("${model.rate.toStringAsFixed(1)}", style: TextStyle(fontSize: 18,color: Colors.black),),

                  ],
                ),
              ),


            ] ,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.teal,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  backgroundImage: NetworkImage(model.image) ,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: IconButton(
                                  onPressed: (){
                                    showNotiDialog(context);
                                  }, icon: Icon(Icons.notifications_active_outlined,color: Colors.white,),
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 15,),
                              if(model.type == "student")
                                CircleAvatar(
                                backgroundColor: Colors.green,
                                  child: IconButton(
                                    onPressed: (){
                                      AdminCubit.get(context).getUserPayments(model.uId);
                                    }, icon: Icon(Icons.monetization_on_outlined,color: Colors.white,),)),
                              SizedBox(width: 15,),
                              CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    onPressed: (){
                                      model.type == "student" ? AdminCubit.get(context).getReserved(model.uId,"students") : AdminCubit.get(context).getReserved(model.uId,"teachers") ;

                                    }, icon: Icon(Icons.calendar_month_outlined,color: Colors.white,),)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.teal,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: Colors.white,
                              controller: bioController,
                              keyboardType: TextInputType.text,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "";
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(

                                          color: Colors.white
                                      )
                                  ),
                                  labelText: "الوصف",
                                  labelStyle: TextStyle(color: Colors.white)
                              ),

                            ),
                            SizedBox(height: 25,),
                            TextFormField(
                              cursorColor: Colors.white,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "";
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(

                                          color: Colors.white
                                      )
                                  ),
                                  labelText: "البريد",
                                  labelStyle: TextStyle(color: Colors.white)
                              ),

                            ),
                            SizedBox(height: 25,),
                            TextFormField(
                              cursorColor: Colors.white,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "";
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(

                                          color: Colors.white
                                      )
                                  ),
                                  labelText: "الاسم",
                                  labelStyle: TextStyle(color: Colors.white)
                              ),

                            ),
                            SizedBox(height: 25,),
                            TextFormField(
                              cursorColor: Colors.white,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "";
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(

                                          color: Colors.white
                                      )
                                  ),
                                  labelText: "الهاتف",
                                  labelStyle: TextStyle(color: Colors.white)
                              ),

                            ),
                            SizedBox(height: 25,),
                            ConditionalBuilder(
                                condition: state is AdminUpdateStudentLoadingState,
                                builder: (context) => CircularProgressIndicator(color: Colors.white,),
                                fallback: (context) => defaultButton(function: (){
                                  model.type == "student" ? AdminCubit.get(context).editStudent(model.uId, bioController.text, emailController.text, nameController.text, phoneController.text, "students") : AdminCubit.get(context).editStudent(model.uId, bioController.text, emailController.text, nameController.text, phoneController.text, "teachers");
                                },
                                    text: "تعديل",
                                    background: Colors.white,
                                    textColor: buttonsColor)),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defaultTextButton(function: (){
                            _showDialog(context);
                                }, text: "حذف المستخدم",color: Colors.red),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _showDialog(BuildContext contex)
  {
    BlurryDelete  alert = BlurryDelete(model);

    showDialog(
      context: contex,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showNotiDialog(BuildContext contex)
  {
    BlurryNoti  alert = BlurryNoti(model);

    showDialog(
      context: contex,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

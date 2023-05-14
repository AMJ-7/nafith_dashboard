import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafith_dashboard/models/userModel.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/colors.dart';

import '../../models/reservation_model.dart';

class ReservationScreen extends StatelessWidget {
  UserModel model ;
  ReservationScreen(this.model);

  @override
  Widget build(BuildContext context) {
        return BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state){},
          builder:(context, state){
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: buttonsColor,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            backgroundImage: NetworkImage(model.image) ,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Text("الجلسات المجدولة"),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConditionalBuilder(
                  condition: AdminCubit.get(context).reverseReserved.length > 0,
                  builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context , index) => buildReservedItem(context, AdminCubit.get(context).reverseReserved[index]),
                    separatorBuilder: (context , index) => SizedBox(height: 10,),
                    itemCount: AdminCubit.get(context).reverseReserved.length,
                  ),
                  fallback: (context) => Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('لا يوجد جلسات محدولة')),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } ,
        );



  }

  Widget buildReservedItem(context ,ReservationModel resModel){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              InkWell(
                onTap: (){
                  // if(AdminCubit.get(context).userModel!.type == "student"){
                  //   navigateTo(context, TeacherProfile(model.teacherId));
                  // }
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: buttonsColor,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: model.type == "student" ? NetworkImage('${resModel.teacherImage}') : NetworkImage('${resModel.studentImage}'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(model.type == "student")...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("حجز مع ${resModel.teacherName}: ",style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                ),
              ],
              if(model.type == "teacher")...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${resModel.studentName} حجز هذا",style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                ),
              ],
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(Icons.bookmark_added ,color: Colors.white,),
                              radius: 25,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("المدة: "),
                                    Text("${resModel.duration} Min",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("من: "),
                                    Text(resModel.from,style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("الى: "),
                                    Text(resModel.to,style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12),),
                                  ],
                                ),

                              ],

                            ),
                            SizedBox(width: 35,)

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



}
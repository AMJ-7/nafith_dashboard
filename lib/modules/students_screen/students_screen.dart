import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafith_dashboard/models/userModel.dart';
import 'package:nafith_dashboard/modules/students_screen/edit_student.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/colors.dart';
import 'package:nafith_dashboard/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class StudentsScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit , AdminStates>(
      listener: (context , state) {},
      builder: (context , state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: defaultTxtForm(
                onChanged: (value){
                  AdminCubit.get(context).searchStudents(value);
                },
                validate: (String? value) {
                  if(value!.isEmpty){
                    return "لا يوجد طالب";
                  }
                  return null ;
                },
                controller: searchController,
                type: TextInputType.text,
                label: "أبحث عن طالب",
                prefix: Icons.search,
              ),
            ),

            Expanded(
              child: ConditionalBuilder(
                condition: AdminCubit.get(context).searchedStudents.length > 0,
                builder:  (context) => ConditionalBuilder(
                  condition: AdminCubit.get(context).searchedStudents.length > 0,
                  builder: (context) => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context , index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildStudentItem(AdminCubit.get(context).searchedStudents[index] , context),
                      ),
                      separatorBuilder: (context , index) => myDivider(),
                      itemCount: AdminCubit.get(context).searchedStudents.length
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(color: buttonsColor,),),
                ),
                fallback: (context) => ConditionalBuilder(
                  condition: AdminCubit.get(context).students.length > 0,
                  builder: (context) => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context , index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildStudentItem(AdminCubit.get(context).students[index] , context),
                      ),
                      separatorBuilder: (context , index) => myDivider(),
                      itemCount: AdminCubit.get(context).students.length
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(color: buttonsColor,),),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
Widget buildStudentItem(UserModel model , context) {
  return  InkWell(
    onTap: (){
      navigateTo(context, EditStudent(model));
    },
    child: Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              backgroundImage: model.image == null ? NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png'): NetworkImage('${model.image}'),
            ),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}' , style: TextStyle(fontSize: 18),),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.person_outline,color: buttonsColor,),
                    Text('${model.gender}',style: TextStyle(fontSize: 16),)
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    ),
  );
}

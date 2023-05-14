import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafith_dashboard/modules/students_screen/students_screen.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/components/components.dart';

class AdminLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit , AdminStates>(
        listener: (context , state) {},
        builder: (context , state) {
          var cubit = AdminCubit.get(context);
          return Scaffold(
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: (){
            //     navigateTo(context, StudentsScreen());
            //   },
            //   child: Icon(Icons.school_outlined),
            //
            // ),

            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){},
                    icon: Icon(Icons.message_outlined)),
              ],
              centerTitle: true,
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index , context);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.monetization_on),
                    label: 'الارباح'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.business_center),
                    label: 'الرقاة'),
                BottomNavigationBarItem(icon: Icon(Icons.school)
                    , label: 'المسترقين'),
                BottomNavigationBarItem(icon: Icon(Icons.settings)
                    ,label: 'الاعدادات'),
              ],

            ),
            body: cubit.screens[cubit.currentIndex],
          );
        }
    );
  }
}

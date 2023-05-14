import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafith_dashboard/firebase_options.dart';
import 'package:nafith_dashboard/modules/admin_login/admin_login.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_cubit.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/bloc_observer.dart';
import 'package:nafith_dashboard/shared/components/constants.dart';
import 'package:nafith_dashboard/shared/network/local/cache_helper.dart';
import 'package:nafith_dashboard/shared/styles/themes.dart';

void main() async{
  print('Main Starting');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();


  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  Widget widget = AdminLogin() ;
  if(uId != null){
    // widget = AdminLayout();
  }else {
    // widget = OnBoardingScreen() ;
  }


  runApp(MyApp(
    startWidget : widget,
  ));
}

class MyApp extends StatelessWidget{
  final dynamic startWidget ;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AdminCubit()..getCoupons()..getMessages()..getCodes()..getTotalEarning()..getTodayEarning()),
      ],
      child: BlocConsumer<AdminCubit , AdminStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light ,
            theme: lightTheme,
            home: Directionality(
                textDirection: TextDirection.rtl,
            child: startWidget),


          );
        },
      ),
    );
  }

}

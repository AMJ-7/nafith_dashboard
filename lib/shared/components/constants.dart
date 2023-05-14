import 'package:nafith_dashboard/shared/components/components.dart';
import 'package:nafith_dashboard/shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      // navigateAndFinish(context, LoginScreen());
    }
  });
}

dynamic uId = '' ;
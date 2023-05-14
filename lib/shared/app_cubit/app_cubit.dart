import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nafith_dashboard/models/message_model.dart';
import 'package:nafith_dashboard/models/payment_model.dart';
import 'package:nafith_dashboard/models/reservation_model.dart';
import 'package:nafith_dashboard/models/sessions_model.dart';
import 'package:nafith_dashboard/models/userModel.dart';
import 'package:nafith_dashboard/modules/dashboard_layout/dashboard_layout.dart';
import 'package:nafith_dashboard/modules/earning_screen/earning_screen.dart';
import 'package:nafith_dashboard/modules/messages_screen/messages_screen.dart';
import 'package:nafith_dashboard/modules/sessions_screen/sessions_screen.dart';
import 'package:nafith_dashboard/modules/settings_screen/settings_screen.dart';
import 'package:nafith_dashboard/modules/students_screen/students_screen.dart';
import 'package:nafith_dashboard/modules/users_screen/users_screen.dart';
import 'package:nafith_dashboard/shared/app_cubit/app_states.dart';
import 'package:nafith_dashboard/shared/components/components.dart';
import 'package:http/http.dart' as http;

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit() : super(AdminInitialStates());

  static AdminCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> screens = [
    EarningScreen(),
    UsersScreen(),
    StudentsScreen(),
    SettingsScreen(),
  ] ;

  List<String> titles = [
    'الارباح' ,
    'المعلمين' ,
    'المسترقين' ,
    'الاعدادات'
  ];

  void changeBottomNav(int index , context){
    currentIndex = index ;
    if(currentIndex == 2){
    getStudents();
    }
    if(currentIndex == 1){
    getTeachers();
    }
    emit(DashboardChangeBottomNavBarState());
  }



  bool existAdmin = false ;
  checkAdmin(String code,context){
    FirebaseFirestore.instance.collection("admins").get().then((value) {
      value.docs.forEach((element) {
        if(code == element.id){
          navigateTo(context, AdminLayout());
          existAdmin = true ;
        }
      });
      if(existAdmin == false){
        showToast(text: "كود خاطئ", state: ToastStates.ERROR);
      }
    });
  }

  addCoupon(String coupon, String discount){
    FirebaseFirestore.instance.collection("coupons").doc(coupon).set({"discount" : discount});
    getCoupons();
    emit(DashboardAddCouponState());
  }

  List coupons = [];
  getCoupons(){
    coupons = [];
    FirebaseFirestore.instance.collection("coupons").get().then((value) {
      value.docs.forEach((element) {
        coupons.add(element.id.toString());
      });
    });
    emit(DashboardGetCouponState());
  }

  deleteCoupon(String coupon){
    FirebaseFirestore.instance.collection("coupons").doc(coupon).delete();
    showToast(text: "تم حذف الكوبون", state: ToastStates.SUCCESS);
    getCoupons();
    emit(DashboardDeleteCouponState());
  }

  addCode(String code){
    FirebaseFirestore.instance.collection("admins").doc(code).set({"code" : code});
    getCodes();
    emit(DashboardAddCodeState());
  }

  List codes = [];
  getCodes(){
    codes = [];
    FirebaseFirestore.instance.collection("admins").get().then((value) {
      value.docs.forEach((element) {
        codes.add(element.id.toString());
      });
    });
    emit(DashboardGetCodesState());
  }

  deleteCodes(String code){
    FirebaseFirestore.instance.collection("admins").doc(code).delete();
    showToast(text: "تم حذف الكوبون", state: ToastStates.SUCCESS);
    getCodes();
    emit(DashboardDeleteCodesState());
  }


  List<UserModel> teachers = [] ;
  void getTeachers(){
    teachers = [];
    FirebaseFirestore.instance
        .collection('teachers')
        .get()
        .then((value) {
      value.docs.forEach((element) {
         teachers.add(UserModel.fromJson(element.data()));
      });
      emit(AdminGetAllTeachersSuccessState());
    }).catchError((error){
      emit(AdminGetAllTeachersErrorState());
    });
  }

  List<UserModel> searchedTeacher = [];
  void searchTeacher(String search){
    searchedTeacher = [];
    for(int i = 0 ; i < teachers.length ; i++){
      if(teachers[i].name.contains(search)){
        searchedTeacher.add(teachers[i]);
      }
    }
    emit(AdminGetSearchSuccessState());
  }

  deleteTeacher(String teacher){
    FirebaseFirestore.instance.collection("teachers").doc(teacher).delete();
    showToast(text: "تم حذف المعلم", state: ToastStates.SUCCESS);
    getTeachers();
    emit(DashboardDeleteTeacherState());
  }

  List<SessionsModel> sessions =[];
  List<SessionsModel> reversedSessions =[];
  void getSessions(String uId,context){
    emit(AdminGetSessionsLoadingState());
    FirebaseFirestore
        .instance
        .collection("teachers")
        .doc(uId)
        .collection("sessions")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      sessions = [];
      reversedSessions = [];
      event.docs.forEach((element) {
        sessions.add(SessionsModel.fromJson(element.data()));
      });
      reversedSessions = sessions.reversed.toList();
      navigateTo(context, SessionsScreen());
      emit(AdminGetSessionsSuccessState());
    });
  }

  List<MessageModel> messages = [] ;
  void getMessages(){
    messages = [];
    FirebaseFirestore.instance
        .collection('contacts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(AdminGetAllMessagesSuccessState());
    }).catchError((error){
      emit(AdminGetAllMessagesErrorState());
    });
  }

  List<UserModel> students = [] ;
  void getStudents(){
    students = [];
    FirebaseFirestore.instance
        .collection('students')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        students.add(UserModel.fromJson(element.data()));
      });
      print(students);
      print("+++++++++++++++++++++++++++++++++++");
      emit(AdminGetAllStudentsSuccessState());
    }).catchError((error){
      emit(AdminGetAllStudentsErrorState());
    });
  }

  List<UserModel> searchedStudents = [];
  void searchStudents(String search){
    searchedStudents = [];
    for(int i = 0 ; i < students.length ; i++){
      if(students[i].name.contains(search)){
        searchedStudents.add(students[i]);
      }
    }
    emit(AdminGetSearchSuccessState());
  }

  deleteUser(type, uId){
    FirebaseFirestore.instance.collection(type).doc(uId).delete();
    showToast(text: "تم حذف المستخدم", state: ToastStates.SUCCESS);
    getStudents();
    emit(DashboardDeleteStudentState());
  }

  void getSessionsStudent(String uId,context){
    emit(AdminGetSessionsLoadingState());
    FirebaseFirestore
        .instance
        .collection("students")
        .doc(uId)
        .collection("sessions")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      sessions = [];
      reversedSessions = [];
      event.docs.forEach((element) {
        sessions.add(SessionsModel.fromJson(element.data()));
      });
      reversedSessions = sessions.reversed.toList();
      navigateTo(context, SessionsScreen());
      emit(AdminGetSessionsSuccessState());
    });
  }



  double total = 0 ;
  getTotalEarning(){
    FirebaseFirestore.instance.collection('payments').get().then((value) {
      value.docs.forEach((element) {
        total = total + double.parse(element.data()['amount']) ;
      });
    });
  }

  double today = 0;
  getTodayEarning(){
    FirebaseFirestore.instance.collection('payments').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['dateTime'] ==  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()){
          today = today + double.parse(element.data()['amount']) ;
        }
      });
    });
  }

  editStudent(uId, bio, email, name, phone,type){
    emit(AdminUpdateStudentLoadingState());
    FirebaseFirestore.instance.collection(type).doc(uId).update({
      'bio': bio,
      'email' : email,
      'name' : name,
      'phone' : phone

    }).then((value) {
      emit(AdminUpdateStudentSuccessState());
      showToast(text: "تم التعديل بنجاح", state: ToastStates.SUCCESS);
    }).catchError((err){
      emit(AdminUpdateStudentErrorState());
      print(err.toString());
    });
  }


  sendNotification(String title,String body, String token, String type,String uId)async{
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status':'done',
      'message':'title',
      'type': type,
      'uId': uId

    };

    try{
      http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: <String,String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAxuSqD8g:APA91bFzOEkz-bGdq4nNmyX9RIepZ2z7AiMeBSJrJ08JFjEv9I4FoqDiDbzASksZqyE6WuAUWLbiR-naeAz3rKuCHXPdWtB8nw5w1oSGhWaxl-_-Gr-pomU1iiFgaMEEcBjQtK5ckVDU'
      },
          body: jsonEncode(<String,dynamic>{
            'notification': <String,dynamic>{'title': title, 'body': body},
            'priority': 'high',
            'data': data,
            'to': '$token'
          })
      );

      if(response.statusCode == 200){
        showToast(text: "تم ارسال الاشعار", state: ToastStates.SUCCESS);
      }else{
        print("something wrong in notification sending");

      }

    }catch(e){}

  }

  List<PaymentModel> userPayments = [];
  getUserPayments(uId){
    userPayments = [];
    FirebaseFirestore.instance.collection("payments").get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] == uId){
          userPayments.add(PaymentModel.fromJson(element.data()));
        }
      });
    }).then((value) {
      emit(AdmingetPaymentsSuccessState());
    });
  }


  List<ReservationModel> reserved =[];
  List<ReservationModel> reverseReserved =[];

  Map<String, dynamic>? alreadyReserved;
  List<Map<String, dynamic>?> alreadyReservedList = [];

  void getReserved(uId, type){
    emit(AdminGetReservedLoadingState());
    FirebaseFirestore
        .instance
        .collection(type)
        .doc(uId)
        .collection("reserved")
        .orderBy('FTS')
        .snapshots()
        .listen((event) {
      reserved = [];
      reverseReserved =[];
      event.docs.forEach((element) {
        reserved.add(ReservationModel.fromJson(element.data()));
        alreadyReserved = {"FTS" : element.data()['FTS'], "LTS" : element.data()['LTS']};
        alreadyReservedList.add(alreadyReserved);
      });
      print(reverseReserved);
      reverseReserved = reserved.reversed.toList();
      emit(AdminGetReservedSuccessState());
    });
  }





}
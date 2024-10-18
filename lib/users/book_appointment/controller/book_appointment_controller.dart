import 'package:flutter/foundation.dart';
import 'package:s_medi/general/consts/consts.dart';
import 'package:intl/intl.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var appNameController = TextEditingController();
  var appMobileController = TextEditingController();
  var appMessageController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  var finalDate = ''.obs;
  List<DateTime> dates = [];
  RxString selectedTime = ''.obs;
  List<String> timeIntervals = [
    "08:00AM-08:30AM",
    "08:30AM-09:00AM",
    "09:00AM-09:30AM",
    "09:30AM-10:00AM",
    "10:00AM-10:30AM",
    "10:30AM-11:00AM",
    "11:00AM-11:30AM",
    "11:30AM-12:00PM",
    "12:00PM-12:30PM",
    "12:30PM-01:00PM",
    "01:00PM-01:30PM",
    "01:30PM-02:00PM",
    "02:00PM-02:30PM",
    "02:30PM-03:00PM",
    "03:00PM-03:30PM",
    "03:30PM-04:00PM",
    "04:00PM-04:30PM",
    "04:30PM-05:00PM",
    "05:00PM-05:30PM",
    "05:30PM-06:00PM",
    "06:00PM-06:30PM",
    "06:30PM-07:00PM",
  ];

  void generateDates() {
    DateTime today = DateTime.now();
    dates = List.generate(
      30,
      (index) => DateTime(today.year, today.month, today.day)
          .add(Duration(days: index)),
    );
  }

  void setInitialTimeForDate(DateTime date) {
    List<String> filteredIntervals = getFilteredTimeIntervals();
    if (filteredIntervals.isNotEmpty) {
      selectedTime.value = filteredIntervals[0];
    } else {
      selectedTime.value = '';
    }
  }

  List<String> getFilteredTimeIntervals() {
    DateTime now = DateTime.now().add(const Duration(minutes: 30));
    List<String> filteredIntervals = [];

    if (selectedDate.value
        .isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
      for (var interval in timeIntervals) {
        try {
          String endTimeStr = interval.split('-')[1].trim();
          DateTime endTime = DateFormat('hh:mma').parse(endTimeStr);
          DateTime todayEndTime = DateTime(
              now.year, now.month, now.day, endTime.hour, endTime.minute);
          if (todayEndTime.isAfter(now)) {
            filteredIntervals.add(interval);
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing time interval: $interval - $e');
          }
        }
      }
    } else {
      filteredIntervals = timeIntervals;
    }

    return filteredIntervals;
  }

  bookAppointment(String docId, String docName, String docNum, context) async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading(true);

        // Fetch current user's fullname from Firestore
        var currentUserUid = FirebaseAuth.instance.currentUser?.uid;
        if (currentUserUid != null) {
          var userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserUid)
              .get();

          // Ensure user document exists and has 'fullname' field
          if (userDoc.exists && userDoc.data()!.containsKey('fullname')) {
            String fullname = userDoc.data()!['fullname'];

            String currentTimestamp =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

            var store =
                FirebaseFirestore.instance.collection('appointments').doc();
            await store.set({
              'appBy': currentUserUid,
              'appDay': finalDate.value.toString(),
              'appTime': selectedTime.value.toString(),
              'appName': fullname,
              'appMobile': appMobileController.text,
              'appMsg': appMessageController.text,
              'appWith': docId,
              'appDocName': docName,
              'appDocNum': docNum,
              'status': 'pending',
              'timestamp': currentTimestamp,
              'review': "false",
            });

            isLoading(false);
            VxToast.show(context, msg: "Appointment is booked successfully");
            Get.back();
          } else {
            isLoading(false);
            VxToast.show(context,
                msg: "User profile not found or missing fullname");
          }
        } else {
          isLoading(false);
          VxToast.show(context, msg: "User not logged in");
        }
      } catch (e) {
        isLoading(false);
        VxToast.show(context, msg: "$e");
      }
    }
  }

  String? validdata(value) {
    if (value!.isEmpty) {
      return 'please fill this';
    }
    RegExp emailRefExp = RegExp(r'^.{3,}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'Enter valid data';
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    generateDates();
    selectedDate.value = dates[0];
    finalDate.value = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    setInitialTimeForDate(selectedDate.value);
  }
}

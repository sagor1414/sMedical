import '../../../general/consts/consts.dart';
import '../../widgets/coustom_button.dart';
import '../../widgets/coustom_textfield.dart';
import '../controller/book_appointment_controller.dart';
import 'package:intl/intl.dart';

class BookAppointmentView extends StatefulWidget {
  final String docId;
  final String docNum;
  final String docName;
  const BookAppointmentView({
    super.key,
    required this.docId,
    required this.docName,
    required this.docNum,
  });

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  var controller = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text("Doctor : ${widget.docName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Appointment date",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.dates.length,
                    itemBuilder: (context, index) {
                      DateTime date = controller.dates[index];
                      bool isSelected =
                          date.isAtSameMomentAs(controller.selectedDate.value);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.selectedDate.value = date;
                            controller.finalDate.value =
                                DateFormat('yyyy-MM-dd')
                                    .format(controller.selectedDate.value);
                            List<String> filteredIntervals =
                                controller.getFilteredTimeIntervals();
                            if (filteredIntervals.isNotEmpty) {
                              controller.selectedTime.value =
                                  filteredIntervals[0];
                            }
                          });
                        },
                        child: Container(
                          width: 80,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xff88d000)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('E').format(date),
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                date.day.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                DateFormat('MMM').format(date),
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Text(
                  "Select Appointment Time",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 70,
                  child: Obx(
                    () {
                      List<String> filteredIntervals =
                          controller.getFilteredTimeIntervals();
                      if (filteredIntervals.isEmpty) {
                        return const Center(
                          child: Text(
                            "No time slots available",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredIntervals.length,
                        itemBuilder: (context, index) {
                          String interval = filteredIntervals[index];
                          bool isSelected =
                              controller.selectedTime.value == interval;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.selectedTime.value = interval;
                              });
                            },
                            child: Container(
                              width: 140,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xff88d000)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  interval,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                10.heightBox,
                "Mobile Number".text.size(AppFontSize.size16).semiBold.make(),
                CoustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appMobileController,
                  hint: "Enter patent mobile number",
                  icon: const Icon(Icons.call),
                ),
                10.heightBox,
                "Your problem".text.size(AppFontSize.size16).semiBold.make(),
                TextFormField(
                  controller: controller.appMessageController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.note_add),
                    hintText: "write your problem in short",
                    hintStyle: TextStyle(),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CoustomButton(
                  onTap: () async {
                    await controller.bookAppointment(
                        widget.docId, widget.docName, widget.docNum, context);
                  },
                  title: "Confirm Appointment",
                ),
        ),
      ),
    );
  }
}

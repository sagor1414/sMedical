import 'package:s_medi/app/widgets/coustom_textfield.dart';

import '../../../general/consts/consts.dart';
import '../../widgets/coustom_button.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: "Doctor name".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Select Appointment date"
                  .text
                  .size(AppFontSize.size16)
                  .semiBold
                  .make(),
              const CoustomTextField(
                hint: "Select date",
                icon: Icon(Icons.calendar_month_outlined),
              ),
              10.heightBox,
              "Select Appointment Time"
                  .text
                  .size(AppFontSize.size16)
                  .semiBold
                  .make(),
              const CoustomTextField(
                hint: "Select time",
                icon: Icon(Icons.watch_later),
              ),
              10.heightBox,
              "patient's name".text.size(AppFontSize.size16).semiBold.make(),
              const CoustomTextField(
                hint: "patient's full name",
                icon: Icon(Icons.person),
              ),
              10.heightBox,
              "Mobile Number".text.size(AppFontSize.size16).semiBold.make(),
              const CoustomTextField(
                hint: "Enter patent number",
                icon: Icon(Icons.call),
              ),
              10.heightBox,
              "Your problem".text.size(AppFontSize.size16).semiBold.make(),
              TextFormField(
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CoustomButton(onTap: () {}, title: "Confirm Appointment"),
      ),
    );
  }
}

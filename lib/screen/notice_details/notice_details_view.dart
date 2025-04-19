import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/enums/validation_type.dart';
import '/screen/notice_details/notice_details_logic.dart';

import '../../widgets/buttons.dart';
import '../../widgets/input_fields.dart';

class NoticeDetailsView extends StatefulWidget {
  const NoticeDetailsView({super.key});

  @override
  State<NoticeDetailsView> createState() => _NoticeDetailsViewState();
}

class _NoticeDetailsViewState extends State<NoticeDetailsView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeDetailsLogic>(builder: (logic) {
      return Scaffold(
        body: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(32),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back),
                        ))),
                Expanded(
                  child: GridView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text("hi sadasd  sadasdasdasdas"),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "test sadsadsadasd asd asd sa  sad sadasdas asdsad  asdasdsa  $index",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .7,
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CostumeButtons.negative(
                        labelText: 'test',
                        isEnabled: true,
                      ),
                    ),
                    Gap(12),
                    Expanded(
                      child: CostumeButtons.positive(
                        labelText: 'test',
                        isEnabled: true,
                      ),
                    ),
                  ],
                ),
                Gap(12),
                CostumeFormField(
                  controller: logic.passwordController,
                  validationType: ValidationType.password,
                  maxLength: 10,
                  inputType: TextInputType.text,
                  hintText: "enter your password",
                  labelText: "password",
                ),
                Gap(12),
                TextFormField(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

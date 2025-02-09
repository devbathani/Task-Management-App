import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/domain/home/task_entity.dart';
import 'package:task_management_app/presentation/widgets/common_boxshadow_container.dart';
import 'package:task_management_app/presentation/widgets/common_textfield.dart';
import 'package:task_management_app/providers/home/home_provider.dart';
import 'package:task_management_app/utils/color.dart';
import 'package:task_management_app/utils/context.ext.dart';
import 'package:task_management_app/utils/text_styles.dart';
import 'package:task_management_app/utils/toast.dart';

@RoutePage()
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.taskData});
  final TaskEntity? taskData;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (widget.taskData != null) {
        Provider.of<HomeProvider>(context, listen: false).updateController(
            widget.taskData!.taskName, widget.taskData!.taskDescription);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeProvider>(
        builder: (context, homeState, _) {
          return SingleChildScrollView(
            child: SizedBox(
              height: context.screenHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.maybePop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Tell us about your task",
                          style: headingStyle.copyWith(
                            color: Color(0xff020617),
                            fontSize: 20.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                      ],
                    ),
                    Gap(33.h),
                    Text(
                      "Task Name",
                      style: headingStyle.copyWith(fontSize: 16.sp),
                    ),
                    Gap(4.h),
                    SizedBox(
                      height: 48.h,
                      child: CommonTextfield(
                        controller: homeState.taskNameController,
                        hintText: "Enter your task name",
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Gap(24.h),
                    Text(
                      "Task Description",
                      style: headingStyle.copyWith(fontSize: 16.sp),
                    ),
                    Gap(4.h),
                    SizedBox(
                      height: 48.h,
                      child: CommonTextfield(
                        controller: homeState.taskDescriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        hintText: "Enter your task description",
                        textInputType: TextInputType.name,
                      ),
                    ),
                    Gap(24.h),
                    Spacer(),
                    CommonBoxshadowContainer(
                      color: greenColor,
                      onTap: () {
                        if (homeState.taskNameController.text.isEmpty) {
                          showToast("Please enter a valid task name", redColor);
                        } else if (homeState
                            .taskDescriptionController.text.isEmpty) {
                          showToast("Please enter a valid task description",
                              redColor);
                        } else {
                          widget.taskData == null
                              ? homeState.addTask(context)
                              : homeState.editTask(
                                  widget.taskData!.id,
                                  homeState.taskNameController.text,
                                  homeState.taskDescriptionController.text,
                                  context,
                                );
                        }
                      },
                      child: Center(
                        child: homeState.homeStates == HomeState.loading
                            ? CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : Text(
                                widget.taskData == null ? "Continue" : "Update",
                                style: headingStyle.copyWith(fontSize: 16.sp),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

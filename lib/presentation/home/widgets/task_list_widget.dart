import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/presentation/widgets/common_container.dart';
import 'package:task_management_app/providers/home/home_provider.dart';
import 'package:task_management_app/routing/app_router.gr.dart';
import 'package:task_management_app/utils/context.ext.dart';
import 'package:task_management_app/utils/text_styles.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeState, _) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 25.h,
            horizontal: 17.w,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: homeState.taskList.length,
            itemBuilder: (context, index) {
              final data = homeState.taskList[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(data.createdAt),
                      style: subHeadingStyle.copyWith(
                        color: Color(0xff94A3B8),
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(11.h),
                    Dismissible(
                      key: Key(data.id.toString()), // Unique key for each item
                      direction:
                          DismissDirection.horizontal, // Swipe left to delete
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.blue,
                        ),
                        child: Icon(Icons.edit, color: Colors.white, size: 30),
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.red,
                        ),
                        child:
                            Icon(Icons.delete, color: Colors.white, size: 30),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          // ✅ Swipe Left → Delete
                          homeState.deleteTask(data.id);
                        } else if (direction == DismissDirection.startToEnd) {
                          context.navigateTo(
                            AddTaskRoute(taskData: data),
                          );
                        }
                      },
                      child: CommonContainer(
                        width: context.screenWidth,
                        border: Border.all(color: Color(0xff94A3B8)),
                        borderRadius: BorderRadius.circular(8.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Gap(12.w),
                                  SizedBox(
                                    width: 223.w,
                                    child: Text(
                                      data.taskName,
                                      style: headingStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(7.h),
                              Divider(color: Color(0xffE2E8F0)),
                              Gap(7.h),
                              Text(
                                data.taskDescription,
                                style: subHeadingStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

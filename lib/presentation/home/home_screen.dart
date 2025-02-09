import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/gen/assets.gen.dart';
import 'package:task_management_app/presentation/home/widgets/animated_button.dart';
import 'package:task_management_app/presentation/home/widgets/task_list_widget.dart';
import 'package:task_management_app/presentation/widgets/common_boxshadow_container.dart';
import 'package:task_management_app/providers/home/home_provider.dart';
import 'package:task_management_app/routing/app_router.gr.dart';
import 'package:task_management_app/utils/color.dart';
import 'package:task_management_app/utils/text_styles.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<HomeProvider>(context, listen: false).loadTasks();
    });
    super.initState();
  }

  Future<void> _refreshData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<HomeProvider>(context, listen: false).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeState, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: homeState.taskList.isEmpty
              ? SizedBox.shrink()
              : CommonBoxshadowContainer(
                  height: 60.h,
                  width: 60.w,
                  onTap: () {
                    context.navigateTo(AddTaskRoute());
                  },
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: greenColor,
                      size: 28.w,
                    ),
                  ),
                ),
          body: RefreshIndicator(
            onRefresh: _refreshData,
            color: greenColor,
            child: homeState.homeStates == HomeState.loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Column(
                      children: [
                        Gap(30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your tasks",
                                style: headingStyle,
                              ),
                              SyncButton(
                                needToUpdate:
                                    homeState.needToUpdate, // ✅ Pass the flag
                                onSync: () {
                                  homeState.syncDataToFirebase();
                                },
                              ),
                            ],
                          ),
                        ),
                        Gap(10.h),
                        Divider(color: Color(0xffE2E8F0)),
                        homeState.taskList.isEmpty
                            ? SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 17.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Gap(50.h),
                                      Image.asset(
                                        Assets.images.emptyFileImage.path,
                                        height: 140.h,
                                      ),
                                      Gap(30.h),
                                      Text(
                                        "No task found",
                                        style: subHeadingStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Gap(16.h),
                                      Text(
                                        "Get started by adding your first task now!",
                                        style: subHeadingStyle.copyWith(
                                          fontSize: 14.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Gap(24.h),
                                      CommonBoxshadowContainer(
                                        height: 40.h,
                                        onTap: () {
                                          context.navigateTo(AddTaskRoute());
                                        },
                                        color: greenColor,
                                        child: Center(
                                          child: Text(
                                            "Add your task",
                                            style: headingStyle.copyWith(
                                              fontSize: 16.sp,
                                              color: darkBlueColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: TaskListWidget(),
                              ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

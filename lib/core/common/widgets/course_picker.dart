import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pacola_quiz/core/resources/theme/app_colors.dart';
import 'package:pacola_quiz/core/utils/core_utils.dart';
import 'package:pacola_quiz/src/course/domain/entities/course.dart';
import 'package:pacola_quiz/src/course/presentation/bloc/course_cubit.dart';
import 'package:pacola_quiz/src/course/presentation/bloc/course_state.dart';

class CoursePicker extends StatefulWidget {
  const CoursePicker({
    required this.controller,
    required this.notifier,
    super.key,
  });

  final TextEditingController controller;
  final ValueNotifier<Course?> notifier;

  @override
  State<CoursePicker> createState() => _CoursePickerState();
}

class _CoursePickerState extends State<CoursePicker> {
  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
          Navigator.pop(context);
        } else if (state is CoursesLoaded && state.courses.isEmpty) {
          CoreUtils.showSnackBar(
            context,
            'No courses found\nPlease add a course first',
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Pick Course',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.background.cardDark),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            suffixIcon: state is CoursesLoaded
                ? PopupMenuButton<String>(
                    offset: const Offset(0, 50),
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (context) {
                      return state.courses
                          .map(
                            (course) => PopupMenuItem<String>(
                              value: course.id,
                              child: Text(course.title),
                              onTap: () {
                                widget.controller.text = course.title;
                                widget.notifier.value = course;
                              },
                            ),
                          )
                          .toList();
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'loading...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please pick a course';
            }
            return null;
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pacola_quiz/core/common/views/loading_view.dart';
import 'package:pacola_quiz/core/common/widgets/not_found_text.dart';
import 'package:pacola_quiz/core/utils/core_utils.dart';
import 'package:pacola_quiz/src/course/presentation/bloc/course_cubit.dart';
import 'package:pacola_quiz/src/course/presentation/bloc/course_state.dart';
import 'package:pacola_quiz/src/home/presentation/refactors/home_header.dart';
import 'package:pacola_quiz/src/home/presentation/refactors/home_subjects.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CoursesLoaded && state.courses.isNotEmpty) {
          final courses = state.courses..shuffle();
          final courseOfTheDay = courses.first;
          CoreUtils.showSnackBar(
            context,
            'Course of the day: ${courseOfTheDay.title}',
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingCourses) {
          return const LoadingView();
        } else if ((state is CoursesLoaded && state.courses.isEmpty) ||
            state is CourseError) {
          return const NotFoundText(
            'No courses found\nPlease contact admin or if you are admin, '
            'add courses',
          );
        } else if (state is CoursesLoaded) {
          final courses = state.courses
            ..sort(
              (a, b) => b.updatedAt.compareTo(a.updatedAt),
            );
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const HomeHeader(),
              const SizedBox(height: 20),
              HomeSubjects(courses: courses),
              const SizedBox(height: 20),
              // const HomeVideos(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

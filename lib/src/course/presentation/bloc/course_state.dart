import 'package:equatable/equatable.dart';
import 'package:pacola_quiz/src/course/domain/entities/course.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseState {
  const CourseInitial();
}

class LoadingCourses extends CourseState {
  const LoadingCourses();
}

class AddingCourse extends CourseState {
  const AddingCourse();
}

class CourseAdded extends CourseState {
  const CourseAdded();
}

class CoursesLoaded extends CourseState {
  const CoursesLoaded(this.courses);

  final List<Course> courses;

  @override
  List<Object> get props => [courses];
}

class CourseError extends CourseState {
  const CourseError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

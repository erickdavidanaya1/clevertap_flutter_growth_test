import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object?> get props => [];
}

class PressButton1Login extends AppEvent {}
class PressButton2UpdateProfile extends AppEvent {}
class PressButton3SimpleEvent extends AppEvent {}
class PressButton4AsyncDemo extends AppEvent {}
class PressButton5GenerateWords extends AppEvent {}
class PressButtonSwitchUser extends AppEvent {}

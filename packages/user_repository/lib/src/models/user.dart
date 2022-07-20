import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.email);

  final String id;
  final String email;

  @override
  List<Object> get props => [id, email];

  static const empty = User('-', '');
}

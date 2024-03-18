part of 'account_bloc.dart';

sealed class AccountEvent {}

class AddAccountEvent extends AccountEvent {
  final String title;
  final String description;
  final DateTime? createdDate;
  final bool? personal;

  AddAccountEvent({
    required this.title,
    required this.description,
    required this.createdDate,
    required this.personal,
  });
}

class EditAccountEvent extends AccountEvent {
  final int id;
  final String? title;
  final String? description;
  final DateTime? createdDate;
  final bool? personal;

  EditAccountEvent({
    required this.id,
    this.title,
    this.description,
    this.createdDate,
    this.personal,
  });
}

class DeleteAccountEvent extends AccountEvent {
  final int id;
  DeleteAccountEvent({required this.id});
}

class AccountListEvent extends AccountEvent {
  final String? search;
  AccountListEvent({this.search});
}

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:flutter/material.dart';

class AccountInput extends StatefulWidget {
  const AccountInput({
    super.key,
    required this.onChanged,
    this.value,
    this.hintText,
  });
  final Function(AccountData account)? onChanged;
  final int? value;
  final String? hintText;

  @override
  State<AccountInput> createState() => _AccountInputState();
}

class _AccountInputState extends State<AccountInput> {
  Future<List<AccountData>> searchAccount(String query) async {
    return await Database.instance.accountList(query);
  }

  @override
  void initState() {
    super.initState();
    searchAccount('').then(
      (value) => setState(
        () {
          accounts = value;
          if (widget.value != null) {
            account = value.firstWhere((element) => element.id == widget.value);
          }
        },
      ),
    );
  }

  AccountData? account;
  List<AccountData> accounts = [];

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<AccountData>.searchRequest(
      futureRequest: searchAccount,
      onChanged: widget.onChanged,
      initialItem: account,
      items: accounts,
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(item.title);
      },
      hintText: widget.hintText ?? 'حساب',
      searchHintText: 'جستجو...',
      noResultFoundText: 'هیچ حسابی یافت نشد!',
      headerBuilder: (context, selectedItem) => Text(selectedItem.title),
      decoration: CustomDropdownDecoration(
        closedBorder: Border.all(
          color: const Color.fromARGB(255, 0, 0, 0),
          width: .75,
          strokeAlign: -1,
        ),
        closedFillColor: Colors.transparent,
      ),
      validator: (value) {
        if (value == null) {
          return 'لطفا حساب مرتبط را انتخاب کنید.';
        }
        return null;
      },
    );
  }
}

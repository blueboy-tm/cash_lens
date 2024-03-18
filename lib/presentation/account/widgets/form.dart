import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/logic/constants/form/validators/text_input.dart';
import 'package:cash_lens/presentation/base/widgets/date_picker.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({
    super.key,
    required this.initialValue,
    required this.onFormSubmit,
    this.onDelete,
    required this.label,
  });
  final AccountData? initialValue;
  final Function(AccountCompanion value) onFormSubmit;
  final Function()? onDelete;
  final Widget label;

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  late final title = TextEditingController(text: widget.initialValue?.title);
  late final description =
      TextEditingController(text: widget.initialValue?.description);
  late DateTime createdDate =
      widget.initialValue?.createdDate ?? DateTime.now();
  late bool personal = widget.initialValue?.personal ?? false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: title,
            validator: TextInputValidator(
              minLength: 3,
              maxLength: 32,
            ).validator,
            decoration: const InputDecoration(
              labelText: 'عنوان حساب',
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: description,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'توضیحات',
            ),
          ),
          const SizedBox(height: 15),
          DatePicker(
            value: createdDate,
            onChanged: (value) {
              setState(() {
                createdDate = value;
              });
            },
            labelText: 'تاریخ ایجاد',
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Transform.scale(
                scale: .8,
                child: Switch(
                  value: personal,
                  onChanged: (value) => setState(() {
                    personal = value;
                  }),
                ),
              ),
              Text(
                'حساب شخصی',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  widget.onFormSubmit.call(AccountCompanion.insert(
                    title: title.text,
                    description: description.text,
                    createdDate: drift.Value.absentIfNull(createdDate),
                    personal: drift.Value.absentIfNull(personal),
                  ));
                },
                child: widget.label,
              ),
              const SizedBox(width: 10),
              if (widget.onDelete != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 251, 103, 103),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      cancelBtnText: 'بستن',
                      confirmBtnText: 'حذف',
                      title: 'از حذف حساب مطمعن هستید؟',
                      titleTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      onConfirmBtnTap: () => widget.onDelete?.call(),
                    );
                  },
                  child: const Text(
                    'حذف',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText,
  });
  final DateTime value;
  final Function(DateTime value) onChanged;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          child: Icon(
            Icons.calendar_month_outlined,
            size: 28,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText ?? 'تاریخ',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 5),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                final now = DateTime.now();
                final date = await showDatePicker(
                  context: context,
                  firstDate: now.subtract(
                    const Duration(days: 365 * 40),
                  ),
                  lastDate: now.add(
                    const Duration(days: 365 * 40),
                  ),
                  initialDate: value,
                );
                if (date == null) {
                  return;
                }
                onChanged.call(DateTime(
                  date.year,
                  date.month,
                  date.day,
                  value.hour,
                  value.minute,
                  value.second,
                  value.millisecond,
                  value.microsecond,
                ));
              },
              child: Text(
                DateFormat(
                  DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                ).format(value),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                final time = await showTimePicker(
                  initialTime: TimeOfDay.fromDateTime(value),
                  context: context,
                );
                if (time == null) {
                  return;
                }
                onChanged.call(DateTime(
                  value.year,
                  value.month,
                  value.day,
                  time.hour,
                  time.minute,
                  value.second,
                  value.millisecond,
                  value.microsecond,
                ));
              },
              child: Text(
                DateFormat(
                  DateFormat.HOUR24_MINUTE_SECOND,
                ).format(value),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

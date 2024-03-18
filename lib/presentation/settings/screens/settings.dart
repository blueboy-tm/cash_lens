import 'dart:io';

import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:path/path.dart' as p;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void getBackup() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    ShareExtend.share(
      p.join(dbFolder.path, 'cash_lens.sqlite'),
      'file',
      sharePanelTitle: 'Cash Lens Backup',
      subject: 'cash_lens_${DateFormat('y-M-d', 'en').format(DateTime.now())}',
    );
  }

  void restoreBackup() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result?.files.isEmpty ?? true) {
      return;
    }
    final dbFolder = await getApplicationDocumentsDirectory();
    await Database.instance.close();
    await File(p.join(dbFolder.path, 'cash_lens.sqlite')).delete();
    await File(result!.files.first.path!)
        .copy(p.join(dbFolder.path, 'cash_lens.sqlite'));
    Database.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تنظیمات'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('cash_lens.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Cash Lens',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: getBackup,
              child: const Text('گرفتن فایل پشتیبانی'),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () async {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  cancelBtnText: 'بستن',
                  confirmBtnText: 'بازنشانی',
                  title:
                      'بعد از بازنشانی اطلاعات فعلی قابل بازگشت نیست. آیا ادامه میدهید؟',
                  titleTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  onConfirmBtnTap: restoreBackup,
                );
              },
              child: const Text('بازنشانی فایل پشتیبانی'),
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('طراحی و توسعه: ارشیا ایهامی'),
                            SizedBox(height: 10),
                            SelectableText('Github: blueboy-tm'),
                            SelectableText('Contact me: t.me/blueboy_tm'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('درباره')),
            const Spacer(),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('نسخه'),
                    const SizedBox(width: 10),
                    Text(snapshot.data?.version ?? ''),
                  ],
                );
              },
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}

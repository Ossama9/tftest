import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:front/colocation/colocation_service.dart';
import 'package:front/user/user_service.dart';

class ColocationSettingsPage extends StatelessWidget {
  const ColocationSettingsPage({super.key, required this.colocationId});
  final int colocationId;

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('confirm_delete'.tr()),
          content: Text('coloc_settings_delete_colocation_confirm'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('confirm'.tr()),
              onPressed: () async {
                var res = await deleteColocation(colocationId);
                if (res == 200) {
                  if (!context.mounted) return;
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('coloc_settings_title'.tr()),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('coloc_settings_modify_colocation'.tr()),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/colocation_update',
                  arguments: {'colocationId': colocationId});
            },
          ),
          ListTile(
            title: Text('coloc_settings_invit_coloc_roommate'.tr()),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/create_invitation',
                  arguments: {'colocationId': colocationId});
            },
          ),
          ListTile(
            title: Text('coloc_settings_ban_coloc_roommate'.tr()),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () async {
              var res = await findUserInColoc(colocationId);
              if (res.isNotEmpty) {
                Navigator.pushNamed(context, '/colocation_members',
                    arguments: {'users': res});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('coloc_settings_no_roommates_to_ban'.tr()),
                ));
              }
            },
          ),
          ListTile(
            title: Text('coloc_settings_delete_colocation'.tr()),
            textColor: Colors.red,
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/setting.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/screen/setting/setting_bloc.dart';
import 'package:todo_app/util/constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  static const routeName = '/setting';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _settingBloc = SettingBloc();
  var languageChanged = false;

  String _languageCode = Setting().getLanguage();
  bool _notification = Setting().getNotification();

  @override
  void initState() {
    _settingBloc.add(LoadSetting());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(languageChanged);
        return true;
      },
      child: BlocListener<SettingBloc, SettingState>(
        bloc: _settingBloc,
        listenWhen: (prev, curr) => curr is SettingLoaded,
        listener: (ctx, state) {
          if (state is SettingLoaded) {
            if (_languageCode != state.languageCode) {
              languageChanged = true;
            }

            setState(() {
              _languageCode = state.languageCode;
              _notification = state.notification;
            });
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(S.current.setting),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ListTile(
                      leading: const SizedBox(
                          height: double.infinity, child: Icon(Icons.language)),
                      title: Text(S.current.language),
                      subtitle: Text(S.current.current_language),
                      trailing: Text(S.current.switch_language),
                      minLeadingWidth: 0,
                      onTap: () => _settingBloc.add(SwitchLanguage()),
                    ),
                    ListTile(
                      leading: const SizedBox(
                          height: double.infinity,
                          child: Icon(Icons.notifications_outlined)),
                      title: Text(S.current.notification),
                      subtitle: Text(S.current.notification_description),
                      trailing: Icon(
                        _notification == true
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: _notification == true
                            ? AppColor.secondary
                            : AppColor.negative,
                      ),
                      minLeadingWidth: 0,
                      onTap: () => _settingBloc.add(ToggleNotification()),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

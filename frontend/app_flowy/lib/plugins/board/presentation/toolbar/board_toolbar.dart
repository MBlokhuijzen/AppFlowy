import 'package:app_flowy/plugins/grid/application/field/field_controller.dart';
import 'package:appflowy_popover/appflowy_popover.dart';
import 'package:flowy_infra/image.dart';
import 'package:flowy_infra/theme.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';
import 'package:flowy_infra_ui/style_widget/icon_button.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'board_setting.dart';

class BoardToolbarContext {
  final String viewId;
  final GridFieldController fieldController;

  BoardToolbarContext({
    required this.viewId,
    required this.fieldController,
  });
}

class BoardToolbar extends StatelessWidget {
  final BoardToolbarContext toolbarContext;
  const BoardToolbar({
    required this.toolbarContext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          _SettingButton(
            settingContext: BoardSettingContext.from(toolbarContext),
          ),
        ],
      ),
    );
  }
}

class _SettingButton extends StatefulWidget {
  final BoardSettingContext settingContext;
  const _SettingButton({required this.settingContext, Key? key})
      : super(key: key);

  @override
  State<_SettingButton> createState() => _SettingButtonState();
}

class _SettingButtonState extends State<_SettingButton> {
  late PopoverController popoverController;

  @override
  void initState() {
    popoverController = PopoverController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppTheme>();
    return AppFlowyPopover(
      controller: popoverController,
      constraints: BoxConstraints.loose(const Size(260, 400)),
      child: FlowyIconButton(
        hoverColor: theme.hover,
        width: 22,
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
          child: svgWidget("grid/setting/setting", color: theme.iconColor),
        ),
      ),
      popupBuilder: (BuildContext popoverContext) {
        return BoardSettingListPopover(
          settingContext: widget.settingContext,
          popoverController: popoverController,
        );
      },
    );
  }
}

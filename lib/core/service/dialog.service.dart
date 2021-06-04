import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';

class DialogService extends StatefulWidget {
  DialogService({Key key, this.builder}) : super(key: key);

  final Widget Function(BuildContext, DialogServiceState) builder;

  static DialogServiceState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedDialogService>()
        .state
        ._withCurrrentContext(context);
  }

  @override
  DialogServiceState createState() => DialogServiceState();
}

class DialogServiceState extends State<DialogService> {
  _DialogContainer _dialogContainer = _DialogContainer();

  BuildContext _currentContext;

  @override
  void initState() {
    super.initState();
    _currentContext = context;
  }

  _withCurrrentContext(BuildContext currentContext) {
    _currentContext = currentContext;

    return this;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedDialogService(
      state: this,
      child: widget.builder(context, this),
    );
  }

  Future<T> showAlert<T>(String title, String message,
      {List<DialogAction> actions, bool dismissable = false}) {
    return _dialogContainer.showAlert<T>(_currentContext, title, message,
        actions: actions, dismissable: dismissable);
  }

  Future<T> showInfo<T>(String message, {VoidCallback callback}) {
    return _dialogContainer.showAlertInfo<T>(_currentContext, message,
        callback: callback);
  }

  Future<T> showError<T>(String message, {VoidCallback callback}) {
    return _dialogContainer.showAlertError<T>(_currentContext, message, true,
        callback: callback);
  }

  Future<T> showWarning<T>(String message, {VoidCallback callback}) {
    return _dialogContainer.showAlertWarning<T>(_currentContext, message,
        callback: callback);
  }

  Future<T> showSuccess<T>(String message, {VoidCallback callback}) {
    return _dialogContainer.showAlertSuccess<T>(_currentContext, message,
        callback: callback);
  }

  StreamController<String> showLoadingDialog<T>({bool dismissible = false}) {
    return _dialogContainer.showLoadingDialog(_currentContext,
        dismissible: dismissible);
  }

  Future<T> showCustomDialog<T>(WidgetBuilder builder,
      {bool barrierDismissible = false, bool dismissible = true}) {
    return _dialogContainer.showCustomDialog<T>(_currentContext, builder,
        barrierDismissible: barrierDismissible, dismissible: dismissible);
  }

  Future<bool> showPrompt(String title, String message,
      {bool dismissable = false, List<DialogAction<bool>> actionList}) {
    return _dialogContainer.showPrompt(_currentContext, title, message,
        dismissable: dismissable, actionList: actionList);
  }

  void closeLoadingDialog() {
    return _dialogContainer.closeLoadingDialog(_currentContext);
  }
}

class _InheritedDialogService extends InheritedWidget {
  _InheritedDialogService({Key key, Widget child, this.state})
      : super(key: key, child: child);

  final DialogServiceState state;

  @override
  bool updateShouldNotify(_InheritedDialogService oldWidget) {
    return false;
  }
}

class _DialogContainer {
  bool _isLoadingDialogOpened = false;

  _buildAndroidAlertDialog(BuildContext context, String title, String message,
      {List<DialogAction> actionsList}) {
    List<MaterialButton> actions = <MaterialButton>[];
    if (actionsList != null) {
      actionsList.forEach((action) {
        actions.add(MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          color: AppColors.primaryColor,
          child: Text(
            action.label,
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white),
          ),
          onPressed: () => action.onPressed(context),
        ));
      });
    }

    return AlertDialog(
        contentPadding: EdgeInsets.only(left: 30, right: 30),
        actionsPadding: EdgeInsets.only(left: 30, right: 30),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Image.asset("assets/images/img_logo.png"),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: actions);
  }

  _buildiOSAlertDialog(BuildContext context, String title, String message,
      {List<DialogAction> actionsList}) {
    List<CupertinoDialogAction> actions = <CupertinoDialogAction>[];
    if (actionsList != null) {
      actionsList.forEach((action) {
        actions.add(CupertinoDialogAction(
          child: Text(action.label),
          onPressed: () => action.onPressed(context),
          isDefaultAction: action.isDefault,
          isDestructiveAction: action.isDestructive,
        ));
      });
    }

    return CupertinoAlertDialog(
        title: Text(title), content: Text(message), actions: actions);
  }

  Future<T> showAlert<T>(BuildContext context, String title, String message,
      {List<DialogAction> actions, bool dismissable = false}) {
    return showDialog<T>(
        context: context,
        barrierDismissible: dismissable || actions == null,
        builder: (dialogContext) => Platform.isIOS
            ? _buildiOSAlertDialog(dialogContext, title, message,
                actionsList: actions)
            : _buildAndroidAlertDialog(dialogContext, title, message,
                actionsList: actions));
  }

  Future<T> showAlertError<T>(
      BuildContext context, String message, bool barrierDismissible,
      {VoidCallback callback}) {
    return showAlert<T>(context, "Error", message,
        dismissable: barrierDismissible,
        actions: [
          DialogAction(
              label: "Ok",
              isDefault: true,
              callback: callback)
        ]);
  }

  Future<T> showAlertInfo<T>(BuildContext context, String message,
      {VoidCallback callback}) {
    return showAlert<T>(context, "Info", message,
        actions: [
          DialogAction(
              label: "Ok",
              isDefault: true,
              callback: callback)
        ]);
  }

  Future<T> showAlertSuccess<T>(BuildContext context, String message,
      {VoidCallback callback}) {
    return showAlert<T>(context, "Success", message,
        actions: [
          DialogAction(
              label: "Ok",
              isDefault: true,
              callback: callback)
        ]);
  }

  Future<T> showAlertWarning<T>(BuildContext context, String message,
      {VoidCallback callback}) {
    return showAlert<T>(context, "Warning", message,
        actions: [
          DialogAction(
              label: "Ok",
              isDefault: true,
              callback: callback)
        ]);
  }

  Future<T> showCustomDialog<T>(BuildContext context, WidgetBuilder builder,
      {bool barrierDismissible = false,
      bool dismissible = true,
      VoidCallback onPop}) {
    return showDialog<T>(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              if (onPop != null) onPop();
              return dismissible;
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  child: Builder(
                    builder: builder,
                  ),
                ),
              ),
            ),
          );
        },
        barrierDismissible: barrierDismissible);
  }

  Future<bool> showPrompt(BuildContext context, String title, String message,
      {bool dismissable = false, List<DialogAction<bool>> actionList}) {
    final actions = (actionList != null && actionList.isNotEmpty)
        ? actionList
        : [
            DialogAction<bool>(
                label: "Yes",
                isDestructive: true,
                callback: () => true),
            DialogAction<bool>(
                label: "No",
                isDefault: true,
                callback: () => false)
          ];
    return showDialog<bool>(
        context: context,
        barrierDismissible: dismissable,
        builder: (dialogContext) => Platform.isIOS
            ? _buildiOSAlertDialog(dialogContext, title, message,
                actionsList: actions)
            : _buildAndroidAlertDialog(dialogContext, title, message,
                actionsList: actions));
  }

  closeLoadingDialog(BuildContext context) {
    if (_isLoadingDialogOpened) {
      Navigator.of(context, rootNavigator: true).pop();
      _isLoadingDialogOpened = false;
    }
  }

  /// Allow to show a indefinite circular progress dialog
  /// To close the dialog if `dismissible` is set to false (default)
  /// you must call `Navigator.of(context).pop()` otherwise you can either call it
  /// or press Back button in Android device.
  ///
  /// It returns a StreamController<String> to update text under the circular progress widget
  StreamController<String> showLoadingDialog(BuildContext context,
      {bool dismissible = false}) {
    if (_isLoadingDialogOpened) {
      closeLoadingDialog(context);
    }

    StreamController<String> controller = StreamController();

    _isLoadingDialogOpened = true;

    showCustomDialog(
        context,
        (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(),
                ),
                StreamBuilder(
                  stream: controller.stream,
                  builder: (_, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(snapshot.data),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            ),
          );
        },
        dismissible: dismissible,
        onPop: () {
          _isLoadingDialogOpened = false;
        });

    return controller;
  }
}

class DialogAction<T> {
  final String label;
  final T Function() callback;
  final bool isDefault;
  final bool isDestructive;

  DialogAction(
      {@required this.label,
      this.callback,
      this.isDefault = false,
      this.isDestructive = false});

  onPressed(BuildContext context) {
    T result;
    if (this.callback != null) result = this.callback();
    Navigator.pop(context, result);
  }
}

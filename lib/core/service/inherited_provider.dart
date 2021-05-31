import 'package:flutter/material.dart';
import 'package:zzoopp_food/core/service/dialog.service.dart';

class ServiceProvider extends StatelessWidget {
  ServiceProvider({Key key, @required this.builder}) : super(key: key);

  final Widget Function(BuildContext, ServiceContainer) builder;

  @override
  Widget build(BuildContext context) {
    ServiceContainer _services = ServiceContainer();
    return DialogService(
      builder: (c, DialogServiceState dialogServiceState) {
        _services.add(DialogServiceState, dialogServiceState);
        return builder(c, _services);
      },
    );
  }
}

class ServiceContainer {
  Map<Type, Object> _services = Map<Type, Object>();

  void add(Type type, Object service) {
    _services[type] = service;
  }

  void remove(Type type) {
    _services.remove(type);
  }

  T get<T>() {
    return _services.containsKey(T) ? _services[T] : null;
  }
}

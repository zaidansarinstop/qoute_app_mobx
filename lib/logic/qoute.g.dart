// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qoute.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QouteStore on _QouteStore, Store {
  late final _$listOfQoutesAtom =
      Atom(name: '_QouteStore.listOfQoutes', context: context);

  @override
  ObservableFuture<List<SingleQoute>>? get listOfQoutes {
    _$listOfQoutesAtom.reportRead();
    return super.listOfQoutes;
  }

  @override
  set listOfQoutes(ObservableFuture<List<SingleQoute>>? value) {
    _$listOfQoutesAtom.reportWrite(value, super.listOfQoutes, () {
      super.listOfQoutes = value;
    });
  }

  late final _$_QouteStoreActionController =
      ActionController(name: '_QouteStore', context: context);

  @override
  dynamic fetch() {
    final _$actionInfo =
        _$_QouteStoreActionController.startAction(name: '_QouteStore.fetch');
    try {
      return super.fetch();
    } finally {
      _$_QouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listOfQoutes: ${listOfQoutes}
    ''';
  }
}

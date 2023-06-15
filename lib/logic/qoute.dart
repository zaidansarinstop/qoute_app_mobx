import 'package:mobx/mobx.dart';
import 'package:qoute_app_mobx/models/single_qoute.dart';
import 'package:qoute_app_mobx/services/qoute_api.dart';
part 'qoute.g.dart';

class QouteStore = _QouteStore with _$QouteStore;

abstract class _QouteStore with Store {
  final _qouteAPI = QouteAPI();

  @observable
  ObservableFuture<List<SingleQoute>>? listOfQoutes;

  @action
  fetch() => listOfQoutes = ObservableFuture(_qouteAPI.fethQoutes());
}

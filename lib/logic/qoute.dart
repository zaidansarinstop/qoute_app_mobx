import 'package:mobx/mobx.dart';

class Qoute with Store {
  @observable
  ObservableList<Map<String, String>> listOfQoutes;

  Qoute(this.listOfQoutes);

  // @action
  // fetchQoutes() => listOfQoutes = ObservableFuture();
}

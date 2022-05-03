import 'package:get/get.dart';

class MainState {
  RxInt tabBarIndex = 0.obs;
  switchIndex(index) {
    tabBarIndex.value = index;
  }
}

final MainState mainState = MainState();
MainState tabState() {
  return mainState;
}

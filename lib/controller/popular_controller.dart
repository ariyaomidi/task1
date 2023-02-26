import 'package:get/get.dart';
import 'package:task1/models/popular_deal.dart';

class DeviceController extends GetxController {
  RxList<PopularDeal> devices = <PopularDeal>[].obs;


  bool isEditing= false;
  String? simCardSelection;
  int index = 0;

}


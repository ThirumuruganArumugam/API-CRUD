import 'package:apiintegration/BO/AvengerBo/AvengerBO.dart';
import 'package:apiintegration/Helpers/Mixins/PopUpMixin.dart';
import 'package:apiintegration/Services/AvengerServices/IAvengerService.dart';
import 'package:mobx/mobx.dart';
import 'package:get_it/get_it.dart';

import '../../Helpers/AppNavigations/NavigationMixin.dart';
part 'HomeScreenModel.g.dart';

// Create a HomeScreenModel
class HomeScreenModel = _HomeScreenModelBase with _$HomeScreenModel,PopUpMixin,NavigationMixin;

abstract class _HomeScreenModelBase with Store {
  
  // Create a final variable named avengerServiceInstance assign it to get the instance of IAvengerService
  final avengerServiceInstance = GetIt.instance.get<IAvengerService>();

  // Declare an observable List<AvengerBO> named as allAvengers and assign empty value
  @observable
  List<AvengerBO> allAvengers = [];

  // Declare an observable bool named as isAvengersLoading and assign false value
  @observable
  bool isAvengersLoading = false;

  /* Create a setIsAvengersLoading methods and pass a required parameter isLoading of type bool */
  @action
  void setIsAvengersLoading ({required bool isLoading}){
    isAvengersLoading = isLoading;
  }

  /* Create a setAllAvengers methods and pass a required parameter newAvengers of type List<AvengersBo>*/
  @action
  void setAllAvengers({required List<AvengerBO> newAvengers}) {

    // Assign the variable named allAvengers to an empty list
    allAvengers = [];

    // Assign the variable named allAvengers to newAvengers
    allAvengers = newAvengers;
  }
}

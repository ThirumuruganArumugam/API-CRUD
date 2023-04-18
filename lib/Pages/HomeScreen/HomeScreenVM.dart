// ignore: file_names
import 'package:apiintegration/BO/AvengerBo/AvengerBO.dart';
import 'package:apiintegration/Helpers/Mixins/PopUpMixin.dart';
import 'package:apiintegration/Helpers/Utitilites/Utilities.dart';
import 'package:apiintegration/Pages/HomeScreen/HomeScreenModel.dart';
import '../../Helpers/AppNavigations/NavigationMixin.dart';

// Create a class named HomeScreenVM which extends the class HomeScreenModel
class HomeScreenVM extends HomeScreenModel {
  /* Get All Avengers from service */
  Future<void> fetchAllAvengers() async {
    try {

      setIsAvengersLoading(isLoading: true);
      
      // Create a variable named data and assign it to call the function getAllAvengers 
      var data = await avengerServiceInstance.getAllAvengers();

      /* Call the setAllAvengers method and pass the parameter newAvenger shoud contain data not a null istead of that has emplty list */
      setAllAvengers(newAvengers: data.content ?? []);

      /* Call the setIsAvengersLoading method and pass the parameter isloading as false */
      setIsAvengersLoading(isLoading: false);
    } 
    // Catch the error exception thrown 
    catch (e) {

      /* Using the parameter call the method */
      e.writeExceptionData();
    }
  }

  /* Create a method named as showinputpopup and pass the parameters */
  void showInputPopUp(int index) {

    try {
      
      // Add the AddPopup method to the popUpController 
      popUpController.add(AddPopup(message: [index, "showHeroNameInputPopUp"]));
    } 
    // 
    catch (e) {
      print(e);
    }
  }

  /* Create a method named as createAvenger and pass the parameters */
  Future<void> createAvenger({required String nameOfAvenger}) async {
    
    
    // 
    AvengerBO newAvenger = AvengerBO(id: null, name: nameOfAvenger);

    try {
      // 
      var data =
          await avengerServiceInstance.createNewAvenger(nameOfHero: newAvenger);
          // 
      await fetchAllAvengers();
    } 
    // 
    catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named as navigateToPreviousView and pass the parameters */
  void navigateToPreviousView() {
    // 
    navigationStream.add(NavigatorPop());
  }

  /* Create a method named as editAvenger and pass the parameters */
  Future<void> editAvenger({required int indexs, required String names}) async {
    /* Create an instance for the class */
    AvengerBO editsAvenger = AvengerBO(id: allAvengers[indexs].id, name: names);

    try {
// 
      var data =
          await avengerServiceInstance.editNameOfAvenger(hero: editsAvenger);
  //  
      await fetchAllAvengers();
    } 
    
    catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named as deleteAvenger and pass the parameters */
  Future<void> deleteAvenger({required int indexs}) async {
    /* Create an instance for the class */
    AvengerBO deleteAvenger = AvengerBO(id: allAvengers[indexs].id, name: null);

    try {
// 
      var data = await avengerServiceInstance.deleteHeroFromAvenger(
          hero: deleteAvenger);
  //  
      await fetchAllAvengers();
    } 
    // 
    catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named as inputPopUp */
  void inputPopUp() {
    try {
      //
      popUpController.add(AddPopup(message: [null, "showInputPopUp"]));
    } catch (e) {
      print(e);
    }
  }


}

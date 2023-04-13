import 'dart:async';

// Create an abstract class named IPopUpMixin
abstract class IPopUpMixin {

}

// Create a class named AddPopup which extends the IPopUpMixin
class AddPopup extends IPopUpMixin {

  // Declare the variable message of type dynamic
  dynamic message;

  /* Create a contructor and pass the required parameter as message */
  AddPopup({required this.message});
}

// Create a mixin named PopUpMixin
mixin PopUpMixin {

  // Create an instance popUpController for the Stream Controller of type IPopmixin  .
  StreamController<IPopUpMixin?> popUpController = StreamController<IPopUpMixin?>();

  /* Create a method named as setAddPop and pass the required parameter as event */
  void setAddPop({required IPopUpMixin event}) {

    /* Add the event to the popupcontroller */
    popUpController.add(event);
    
  }

  /* Create a method named setClosePop */
  void setClosePop()async{

    /* close the popunpcontroller instance */
    await popUpController.close();
  }
}

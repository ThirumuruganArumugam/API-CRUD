import 'dart:async';

// Create an abstract class named ITextMixin
abstract class ITextMixin {

}


// Create a class named AddTextField which extends the ITextMixin abstract class
class AddTextField extends ITextMixin {

  // Declare the variable named data of type String
  String data;

  /* Create a contructor of the class and pass the required parameter */
  AddTextField({required this.data});
}

// Create a mixin named as TextMixin
mixin TextMixin {

  // Create an instance for the Stream Contrller named as textFieldController.
  StreamController<ITextMixin?> textFieldController = StreamController<ITextMixin?>();

  /* Create a method named as setAddText and pass the required parameter */
  void setAddText({required ITextMixin event}) {

    /* Add the event tot he textFieldController */
    textFieldController.add(event);
    
  }
  
  /* Create a method named setCloseText */
  void setCloseText()async{
    
    /* close the textFieldController instance */
    await textFieldController.close();
  }
}

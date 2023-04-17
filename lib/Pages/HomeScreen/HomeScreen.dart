// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:apiintegration/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:apiintegration/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:apiintegration/Helpers/Mixins/PopUpMixin.dart';
import 'package:apiintegration/Pages/HomeScreen/HomeScreenVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Create a statefulwidget for HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.extraData}) : super(key: key);
  final Object extraData;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create an instance for the HomeScreenVM
  final HomeScreenVM _homeScreenVM = HomeScreenVM();

  // Create an instance for the TextEditingController
  final TextEditingController _editingController = TextEditingController();

  // Create an instance for the TextEditingController
  final TextEditingController _textController = TextEditingController();

  /* Create a method named as initState */
  @override
  void initState() {
    super.initState();

    /* Listen to the popupcontroller stream */
    _homeScreenVM.popUpController.stream.listen((event) {
      
      // Check whether the event is same as Addpopup
      if (event is AddPopup) {
        
        // Checks the expression
        switch (event.message[1]) {
          
          // Check the case
          case "showHeroNameInputPopUp":
            
            /* Call the method and pass the parameter */
            showHeroNameInputPopUp(event.message[0]);
            
            // Assigning the controller to the instance for calling the name in all avengers
            _editingController.text =
                _homeScreenVM.allAvengers[event.message[0]].name.toString();
            break;

          // check the case
          case "showInputPopUp":
            /* call the function */
            showInputPopUp();
            break;
        }
      }
    });

    /* Listen to the navigationStream stream */
    _homeScreenVM.navigationStream.stream.listen((event) {
      // Check whether the event is same as NavigatorPop
      if (event is NavigatorPop) {
        /* Pop the context */
        context.pop();
      }
    });

    /* Call the function fetchAllAvengers using the instance */
    _homeScreenVM.fetchAllAvengers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        /* Invoke the onPress function */
        onPressed: () {
          
          /* Using the instance call the function inputPopup */
          _homeScreenVM.inputPopUp();
          
          /* Using the instance call the function inputPopup */
          _textController.clear();
        },
        label: const Icon(Icons.add_outlined),
      ),
      appBar: AppBar(
        title: const Text("AVENGERS DATABASE"),
        actions: const [],
      ),
      body: Column(
        children: [
          
          // Observes the all the changes happening.
          Observer(
            builder: (context) {
              return 
              
              // Gives the visibility of the widget
              Visibility(
                visible:
                    
                    /* Using the instance call bool class */
                    _homeScreenVM.isAvengersLoading,
                child: const CircularProgressIndicator(),
              );
            },
          ),
          Expanded(
            child: 

          // Observes the all the changes happening.
            Observer(builder: (context) {
              return 
              
              // Gives the visibility of the widget
              Visibility(
                visible:
              
                    /* Using the instance call bool class */
                    !_homeScreenVM.isAvengersLoading,
                child: ListView.builder(
                  itemCount:
              
                      /* Using the instance call the list of allAvengers class's length */
                      _homeScreenVM.allAvengers.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Text(
              
                          /* Using the instance call the id of the class allavengers */
                          _homeScreenVM.allAvengers[index].id.toString()),
                      title: Text(
              
                          /* Using the instance call the name of the class allavengers */
                          _homeScreenVM.allAvengers[index].name ?? ""),
                      trailing: SizedBox(
                        height: 50,
                        width: 150,
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  
                                  /* Using the instance call the showInputPopUp function and its parameter */
                                  _homeScreenVM.showInputPopUp(index);
                                },
                                child: const Icon(Icons.edit)),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  
                                  /* Using the instance call the deleteAvenger function and its parameter */
                                  _homeScreenVM.deleteAvenger(indexs: index);
                                },
                                child: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  /* Declare a method named showHeroNameInputPopUp and pass a parameter. */
  Future<void> showHeroNameInputPopUp(int index) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit"),
            content: SingleChildScrollView(
              child: ListBody(children: [
                TextFormField(
                  readOnly: true,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  
                  /* Create a textEditingController instance as _editingController*/
                  controller: _editingController,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      label: const Text("Edit Name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
              ]),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                ),
                onPressed: () {
                  
                  /* Using the instance call the navigateToPreviousView function */
                  _homeScreenVM.navigateToPreviousView();
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                ),
                onPressed: () {
                  
                  /* Using the instance call the editAvenger function and pass the parameter*/
                  _homeScreenVM.editAvenger(
                      indexs: index, names: _editingController.text);
                  
                  /* Using the instance call the function navigateToPreviousView */
                  _homeScreenVM.navigateToPreviousView();
                },
                child: const Text("Save"),
              ),
            ],
          );
        });
  }

  /* Create a method named showInputPopUp */
  Future<void> showInputPopUp() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add New Name"),
            content: SingleChildScrollView(
              child: ListBody(children: [
                TextFormField(
                  
                  /* Create a textEditingController instance as _textController */
                  controller: _textController,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      label: const Text("Add Name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
              ]),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                ),
                onPressed: () {
                  
                  /* Using the instance call the navigateToPreviousView */
                  _homeScreenVM.navigateToPreviousView();
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                ),
                onPressed: () {
                  
                  /* Using the instance call the createAvenger and pass the parameter */
                  _homeScreenVM.createAvenger(
                      nameOfAvenger: _textController.text);
                  
                  /* Using the instance call the navigateToPreviousView */
                  _homeScreenVM.navigateToPreviousView();
                },
                child: const Text("Add"),
              ),
            ],
          );
        });
  }
}

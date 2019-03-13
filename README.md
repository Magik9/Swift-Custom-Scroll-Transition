# IOS-Slide-Interactive-Transition
Simplest interactive transition sliding between view-controllers.

There are many tutorals about custom interactive trasition but most of them can result even more exhaustive if you want to implement only the strictly required methods and objects.

So i create a signle class that hold all we need to perform an interactive transition where both presenting and presented viewcontrollers are animated. 

In this case when the user start the gesture from the edge of the screen the views involved in the transition are translated.

Our class TransitionManager is composed by three elements:

- Ui: 

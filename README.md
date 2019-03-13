# IOS-Slide-Interactive-Transition
Simplest interactive transition sliding between view-controllers(SWIFT).

There are many tutorals about custom interactive trasition but most of them can result even more exhaustive if you want to implement only the strictly required methods and objects.

So i create a signle class that hold all we need to perform an interactive transition where both presenting and presented viewcontrollers are animated. 

In this case when the user start the gesture from the edge of the screen the views involved in the transition are translated.



Class TransitionManager is composed by four elements:

- UIPercentDriveInteractiveTransition: the object that update the transition parallel whit the gesture on the screen.
  Methods used:
  -update
  -finish
  
- UIViewControllerAnimatedTransition: the protocol where the animation are executed.
  Methods used:
  -AnimateTransition
  -TranstionDuration
  
- UIViewControllerTransitioningDelegate: the protocol that provides the two previous element when the transition begining.
  Methods used:
  -animationController(forPresented:presenting:source:)
  -animationController(forDismissed:)
  -interactionControllerForPresentation(using:)
  -interactionControllerForDismissal(using:)
  
- UIScreenEdgePanGestureRecogniser: the object that handle the user's gesture on the screen.
  Methods used:
  -handleSwipeRight
  -handleSwipeLeft
  
  
  
 To make the transition works you only need to:
 
 -Instanciate a TransitionManager object.
 -Setting transitioningdelegate of presented viewcontroller whit this object.
 -Setting the presentingVc and presentedVc properties of the object.
  

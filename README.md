# VamaCCMusicAlbum

---

## Features

- [x] US Top 100 Music Album Collection
- [x] Lazy Loading with Placholder Images
- [x] Pull to Refresh
- [x] Genre View in Music Store
- [x] Album View in Music Store
- [x] Realm Database Saving (For Offline Usage)
- [x] App Icon

## Frameworks

---
- Realm
--- 

## Code Design

### MVVM 

    - View Controllers are strictly used only for instantiation of view models, views and navigation purposes, with business logic fully decoupled.
    - Every View Controller/View Model/View is a subclass of its <MusicAlbum> counterpart, which provides the base for decoupling and instantiation.
    - View Pairing and View Model Pairing are setup in route.plist, which will be instantiated respectively whenever a view controller is pushed.
    - Views will only handle UI, View Models will only handle business logic and calculations, and models layer will be where database/network operations are housed in.
    - Future improvements can be made to decoupling through further network calls or configuration retrieval to provide runtime A/B testing, such as provision of a key-value map online to decide the view models and views to utilize as long as it is pre-built into the application. 
    
### Coordinator Pattern With Plist Routing

    - AppDelegate will instantiate a flow coordinator, which reads from route.plist to determine and instantiate the primary scene of the app, which in this case will be Top 100 Scene.
    - Start(Initialize), Go to Next, back functionalities are inbuilt in the flow coordinator for view models/app delegate to directly interact with.
    - Custom Alerts are provisioned in the same coordinator to allow view models to ping an alert to the user at any one time.
    - Child coordinators will be used in future-proofing, in the event of new flows arising in the future, it is not used in this particular assessment.
    - Future improvements can include establishing child flows, decoupling flows through network calls or configurations retrieval as well as regex deeplink routing, where every scene(VC in this case) is provided with a deeplink to directly route to their respective VCs instead of utilizing a local plist. 
     
### Repository Pattern with Observers

    - A repository protocol is built in FeedRepository singleton to store all feeds provided to our application. It encompasses basic CRUD methods to allow for easy database operations in Realm.
    - All methods are wrapped with try catch blocks which provide their respective error handling.
    - An additional parse json method is provided to parse any dictionary map(in this assessment) to directly insert or update into the database, before sending back to the respective views for view updates
    - Completion blocks are used in this instance for a quicker implementation (since I'm more proficient in it :/), while I understand we could probably do the same with async/await methods
    - A Feed instance singletopn is established with observer methods to quickly access all feeds and observe data changes in state. Music Album Instance is currently only for future-proofing for future requirements/flows.
    - Helper methods for realm extensions are also present to cast between Realm objects and Swift Objects, particularly Lists and arrays
    - Future improvements will include coupling of View Models with their respective observers through event bus like notification observers to observe changes of data and we can better react to them in an efficient manner. 
     
### Extensions for Utility Methods and Constants

    - This is where I store all other utility methods which include: -
        -- Reading from plist
        -- Establishing of String constants for string storage and key storage (Could be changed to full network / localization strings later on)
        -- Instantiation of View Controllers through its class names
        -- UIColor through Hexadecimal Integers for easy UI creation (Colors)
        -- UIImageView + Loading for simple preloading placeholders and switching to network images once it is loaded

## Code Structure

- View Controller
- Models
- Views
 -- Cells (CollectionView)
- View Models
- Extensions
- Coordinators
- Routers
  -- vmPairing (Controller to View Model)
  -- viewPairing (Controller to View)
  -- primaryController (Root View Controller establishment)
  -- flowBase (Which controller goes to which controller)

 



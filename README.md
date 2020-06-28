# Jet2Travels


Notes

Follows Specification :

- Using Api Fetch Request for Listing.
- Using Core Data for Storing the list response.
- Using Paging for Fetching the list.
- Displaying Feeds As per the UI recommened.
- TableView Height is Dynamic.
- Image is Downloading only once , Image Caching Mechanism used for Caching
- Added Unit Test Case
- Code is Commited over the git as per recommended.


Follows Guideline:

-  Using Git for Managing Code versioning
-  Using MVVM Design Pattern
-  Orientation Support
-  Code is Committed in a Proper Way
-  Using Storyboard with AutoLayouts
-  Using UrlSession In Protocol Oriented Approach
-  Using TableView as a Container
-  Added comment in Source Files
- Support offline storage 


Flow:

- On launch request the api for fetch the data for first page.
- After receiving the response save list data to Core data Storage.
- Application will support offline data storage.
- Once we reach at the bottom of listing will have a load more button.
- Once we click on Load more button request is made for next page.
- Same Process follows for making list avaialble to user for every next page.

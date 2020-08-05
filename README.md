![](https://raw.githubusercontent.com/TheCodeMonks/NYTimes-iOS/master/NYTimes%20Screenshots/Banner%400.25x.png)
![SwiftUI](https://img.shields.io/badge/Interface-SwfitUI-red)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/TheCodeMonks/NYTimes-iOS/blob/master/LICENSE)
![GitHub forks](https://img.shields.io/github/forks/TheCodeMonks/NYTimes-iOS?label=Fork&style=social)
![GitHub Stars](https://img.shields.io/github/stars/TheCodeMonks/NYTimes-iOS?label=Stars&style=social)
![GitHub Watchers](https://img.shields.io/github/watchers/TheCodeMonks/NYTimes-iOS?label=Watchers&style=social)


[![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https://github.com/TheCodeMonks/NYTimes-iOS)](http://twitter.com/share?text=Checkout+this+cool+project+made+with+SwiftUI,+by+@iamwaseem99&url=https://github.com/TheCodeMonks/NYTimes-iOS&hashtags=swiftui,ios,iphone,news,github,iosdevelopers,swift,xcode)
[![Twitter Follow](https://img.shields.io/twitter/follow/iamwaseem99?style=social)](https://twitter.com/iamwaseem99)



# NYTimes

NY Times is an Minimal News 🗞 iOS application built to describe the use of **SwiftSoup** and **CoreData** with **SwiftUI**.

## ⛓ Features

<table style="width:100%">
  <tr>
    <th>Articles Loading </th>
    <th>Browse by Category</th> 
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/TheCodeMonks/NYTimes-iOS/master/NYTimes%20Screenshots/gifs/HomeLoading.gif" width=250 height=600 /></td> 
    <td><img src="https://raw.githubusercontent.com/TheCodeMonks/NYTimes-iOS/master/NYTimes%20Screenshots/gifs/browseByCategories.gif" width=250 height=600 /></td> 
  </tr>
  <tr>
    <th>Bookmark a Article using 3D Touch. </th>
    <th>Deleting bookmarks is just one swipe away</th> 
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/TheCodeMonks/NYTimes-iOS/master/NYTimes%20Screenshots/gifs/bookmark3d.gif" width=250 height=600 /></td>
    <td><img src="https://github.com/TheCodeMonks/NYTimes-iOS/blob/master/NYTimes%20Screenshots/gifs/manageBookmark.gif" width=250 height=600 /></td>
  </tr>
</table>

## 📝 Table of Contents  
- [Requirements](#requirements)
- [What you can learn?](#whatyoucanlearn)
- [Technical Background](#techbackground)
- [Dependencies](#dependencies)
- [Project Structure](#projectstructure)
- [Features](#features)
- [Contribute](#contribute)
- [Contact](#contact)
- [License](#license)




<a name="requirements"/>

## ⚙️ Requirements
```
iOS 14+
Xcode 12 beta 3
```
> :warning: This App is compiled with Xcode 12 beta 3. Using other versions of xcode might break the project.

<a name="whatyoucanlearn"/>

## 📚 What you can learn?
- You can learn Technologies like
  - SwiftUI
  - CoreData
  - Combine
  - Web Scraping
- You can learn various Design patterns from this project such as
  - Dependency injection
  - Repository 
  - Singleton
  - Observers
- You can learn MVVM Two way binding Architecture for SwiftUI with Combine framework

<a name="techbackground"/>

## 🛠 Technical Background
- NYTimes App was made using SwiftUI as the Core interface with Two Way Binding MVVM Architecture using Combine framework. 
- CoreData is used to store the Article Bookmarks offline in device so that the user can access it at later time.
- SwiftSoup is used to scrap the required details from the NYTimes website.
- The User interface of this app mostly uses the inbuilt iOS components to keep the User experience close to the native feel.
- Bookmarks can be added as easy as a 3d-touch from Homescreen or a tap in bookmark icon in the detailed article screen.
- This project was built in the mindset of modularity and good coding patterns. Multiple design patterns like Dependency injection, Repository pattern, Singleton Pattern etc.

<a name="dependencies"/>

## 🔗 Dependencies

This project uses SPM (Swift Package Manager) as Dependency manager.

 - [SwiftSoup](https://github.com/scinfu/SwiftSoup)
 - [Kingfisher](https://github.com/onevcat/Kingfisher)

<a name="projectstructure"/>

## ⛓ Project Structure

    NYTimes                 # Root Group
    .
    ├── Utilities           # Utilities for Fetching data ans Scraping HTML
    ├── Globals             # Contains App constants
    ├── Persistence         # Coredata files. Contains coredata model and Singleton for ManagedObjectContext
    ├── Views               # SwiftUI Views
    ├── Repository          # Repository for Coredata
    ├── ViewModel           # Viewmodels for SwiftUI Views
    ├── Model               # Model files
    |   └── Coredata Model  # Coredata model subclasses
    |
    └── Supporting files    # Misc. files like Appdelegate, SceneDelegate.

## Architecture
    
This app uses MVVM architecture.

![MVVM](https://raw.githubusercontent.com/TheCodeMonks/NYTimes-iOS/master/NYTimes%20Screenshots/MVVM.jpeg)


<a name="contribute"/>

## ✏️ Contribute

If you want to contribute to this library, you're always welcome!

### What you can do
You can contribute us by filing issues, bugs and PRs.

### Before you do
Before you open a issue or report a bug, please check if the issue or bug is related to Xcode or SwiftUI.

### Contributing guidelines:
- Open issue regarding proposed change.
- Repo owner will contact you there.
- If your proposed change is approved, Fork this repo and do changes.
- Open PR against latest `dev` branch. Add nice description in PR.
- You're done!

## ☕️ Donation
If this project help you reduce time to develop, you can give me a cup of coffee :) 

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/iamwaseem99)

<a name="contact"/>

## 📱 Contact

Have an project? DM us at 👇

Drop a mail to:- thecodemonksorg@gmail.com

<a name="license"/>

## ⚖️ [License](https://github.com/TheCodeMonks/NYTimes-iOS/blob/master/LICENSE)

```
MIT License

Copyright (c) 2020 TheCodeMonks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

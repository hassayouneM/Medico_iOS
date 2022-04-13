# Medico_iOS

This project is an iOS project fo a mobile app using swift

Getting Started
To get you started you can simply clone the repository:

git clone https://github.com/hassayouneM/Medico_iOS
and install the dependencies

## Contents

If you are looking for something specific, you can jump right into the relevant section from here.

1. [Getting Started](#getting-started)
1. [Architecture](#architecture)
1. [Assets](#assets)
1. [Coding Style](#coding-style)


## Getting Started

### Xcode

[Xcode][xcode] is the IDE of choice for most iOS developers, and the only one officially supported by Apple. There are some alternatives, of which [AppCode][appcode] is arguably the most famous, but unless you're already a seasoned iOS person, go with Xcode. Despite its shortcomings, it's actually quite usable nowadays!

To install, simply download [Xcode on the Mac App Store][xcode-app-store]. It comes with the newest SDK and simulators, and you can install more stuff under _Preferences > Downloads_.

[xcode]: https://developer.apple.com/xcode/

### Project Setup

A common question when beginning an iOS project is whether to write all views in code or use Interface Builder with Storyboards or XIB files. Both are known to occasionally result in working software. However, there are a few considerations:


#### Why Storyboards?
* For the less technically inclined, Storyboards can be a great way to contribute to the project directly, e.g. by tweaking colors or layout constraints. However, this requires a working project setup and some time to learn the basics.
* Iteration is often faster since you can preview certain changes without building the project.
* Custom fonts and UI elements are represented visually in Storyboards, giving you a much better idea of the final appearance while designing.
* For [size classes][size-classes], Interface Builder gives you a live layout preview for the devices of your choice, including iPad split-screen multitasking.

[size-classes]: http://futurice.com/blog/adaptive-views-in-ios-8

### Dependency Management


### Project Structure

To keep all those hundreds of source files from ending up in the same directory, it's a good idea to set up some folder structure depending on your architecture. For instance, you can use the following:

    ├─ Models
    ├─ Views
    ├─ ViewModels


### AFNetworking/Alamofire

The majority of iOS developers use one of these network libraries. While `NSURLSession` is surprisingly powerful by itself, [AFNetworking][afnetworking-github] and [Alamofire][alamofire-github] remain unbeaten when it comes to actually managing queues of requests, which is pretty much a requirement of any modern app. We recommend AFNetworking for Objective-C projects and Alamofire for Swift projects. While the two frameworks have subtle differences, they share the same ideology and are published by the same foundation.

[afnetworking-github]: https://github.com/AFNetworking/AFNetworking
[alamofire-github]: https://github.com/Alamofire/Alamofire

### Auto Layout Libraries
If you prefer to write your views in code, chances are you've heard of either Apple's awkward syntaxes – the regular `NSLayoutConstraint` factory or the so-called [Visual Format Language][visual-format-language]. The former is extremely verbose and the latter based on strings, which effectively prevents compile-time checking. Fortunately, they've addressed the issue in iOS 9, allowing [a more concise specification of constraints][nslayoutanchor].


## Architecture

* [Model-View-ViewModel (MVVM)][mvvm]
    * Motivated by "massive view controllers": MVVM considers `UIViewController` subclasses part of the View and keeps them slim by maintaining all state in the ViewModel.
    * To learn more about it, check out Bob Spryn's [fantastic introduction][sprynthesis-mvvm].


[mvvm]: https://www.objc.io/issues/13-architecture/mvvm/

    

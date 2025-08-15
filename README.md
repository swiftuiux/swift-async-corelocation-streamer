# Async location streamer using new concurrency

### Please star the repository if you believe continuing the development of this package is worthwhile. This will help me understand which package deserves more effort.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftuiux%2Fswift-async-corelocation-streamer%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/swiftuiux/swift-async-corelocation-streamer) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftuiux%2Fswift-async-corelocation-streamer%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/swiftuiux/swift-async-corelocation-streamer)

This package uses Core Location under the hood to harness the power of GPS for accurate and efficient location tracking. By leveraging Swift’s async/await concurrency model, it provides a modern, clean, and scalable way to stream GPS data asynchronously. Core Location works with GPS, Wi-Fi, and cellular networks to determine a device’s position, ensuring both high accuracy and optimal performance.

## [SwiftUI example](https://github.com/swiftuiux/corelocation-manager-tracker-swift-apple-maps-example)

 Available for watchOS
 
 ![simulate locations](https://github.com/swiftuiux/swift-async-corelocation-streamer/blob/main/img/apple_watch_swiftui.gif)



if you are using the simulator don't forget to simulate locations

 ![simulate locations](https://github.com/swiftuiux/swift-async-corelocation-streamer/blob/main/img/image11.gif)

 ## Features
- [x] Using new concurrency swift model around CoreLocation manager
- [x] Extend API to allow customization of `CLLocationManager`
- [x] Support for iOS from 14.1 and watchOS from 7.0
- [x] Seamless SwiftUI Integration Uses `@Published` properties for real-time UI updates or @observable is you can afford iOS17 or newer.
- [x] Streaming current location asynchronously
- [x] Different strategies - Keep and publish all stack of locations since streaming has started or the last one
- [x] Errors handling (as **AsyncLocationErrors** so CoreLocation errors **CLError**)


## How to use
 
### 1. Add to info the option "Privacy - Location When In Use Usage Description" 
 ![Add to info](https://github.com/swiftuiux/swift-async-corelocation-streamer/blob/main/img/image2.png)
 
 **Background Updates**
   - Ensure the app has `location` included in `UIBackgroundModes` for background updates to function.
 
### 2. Add or inject LocationStreamer into a View

```
    @StateObject var service: LocationStreamer 
```
For iOS 17+ and watchOS 10+, using @State macro:
```
    @State var service: ObservableLocationStreamer
```

### 3. Call LocationStreamer method start() within async environment or check SwiftUI example
```
    try await service.start()
```

### LocationStreamer parameters

|Param|Description|
| --- | --- |
|strategy| Strategy for publishing locations. Default value is **KeepLastStrategy**. Another predefined option is **KeepAllStrategy**, or you can implement and test your own custom strategy by conforming to the `LocationResultStrategy` protocol. |
|accuracy| The accuracy of a geographical coordinate.|
|activityType| Constants indicating the type of activity associated with location updates.|
|distanceFilter| A distance in meters from an existing location to trigger updates.|
|backgroundUpdates| A Boolean value that indicates whether the app receives location updates when running in the background. |

or

|Param|Description|
| --- | --- |
|strategy| Strategy for publishing locations. Default value is **KeepLastStrategy**. Another predefined option is **KeepAllStrategy**, or you can implement and test your own custom strategy by conforming to the `LocationResultStrategy` protocol. |
|locationManager| A pre-configured `CLLocationManager`. |


### Default location
1. Product > Scheme > Edit Scheme
2. Click Run .app
3. Option tab
4. Already checked Core Location > select your location
5. Press OK

 ![Default location](https://github.com/swiftuiux/swift-async-corelocation-streamer/blob/main/img/image6.png)
 
 
## Documentation(API)
- You need to have Xcode 13 installed in order to have access to Documentation Compiler (DocC)
- Go to Product > Build Documentation or **⌃⇧⌘ D**

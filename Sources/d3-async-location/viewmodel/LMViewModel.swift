//
//  LocationManagerViewModel.swift
//  
//
//  Created by Igor on 03.02.2023.
//

import SwiftUI
import CoreLocation


/// ViewModel posting locations asynchronously
/// Add or inject LMViewModel into a View ```@EnvironmentObject var model: LMViewModel```
/// Call method start() within async environment to start async stream of locations
@available(iOS 15.0, watchOS 7.0, *)
public final class LMViewModel: ILocationManagerViewModel{
    
    // MARK: - Public
    
    /// List of locations
    @MainActor @Published public private(set) var locations : [CLLocation] = []
            
    // MARK: - Private
    
    /// Async locations manager
    private let manager : LocationManagerAsync
    
    /// Current streaming state
    private var state : LocationStreamingState = .idle
    
    /// Check if streaming is idle
    private var isIdle: Bool{
        state == .idle
    }
       
    // MARK: - Life circle
    
    /// - Parameters:
    ///   - accuracy: The accuracy of a geographical coordinate.
    ///   - backgroundUpdates: A Boolean value that indicates whether the app receives location updates when running in the background
    public init(accuracy : CLLocationAccuracy? = nil, backgroundUpdates : Bool = false){
        manager = LocationManagerAsync(accuracy, backgroundUpdates)
    }
    
    deinit{
        #if DEBUG
        print("deinit LMViewModel")
        #endif
    }
    
    // MARK: - API
    
    /// Start streaming locations
    public func start() async throws{
        
        guard isIdle else{
            throw AsyncLocationErrors.streamingProcessHasAlreadyStarted
        }
        
        state = .streaming
        
        do {
            for try await coordinate in try await manager.start{
                await add(coordinate)
            }
        }catch{
            
            state = .idle // if access was not granted just set state to idle, manager did not get started in this case
            
            if isStreamCancelled(with: error){ stop() }
            
            throw error
        }
    }
    
    /// Stop streaming locations
    public func stop(){
  
            manager.stop()
            state = .idle

            #if DEBUG
            print("stop viewmodel")
            #endif
    }
    
    // MARK: - Private
    
    
    /// Check if it is cancelation error
    /// - Parameter error: Error from manager
    /// - Returns: true is stream was canceled
    func isStreamCancelled(with error : Error) -> Bool{
        
        if let e = error as? AsyncLocationErrors{
            return [AsyncLocationErrors.streamCancelled, .unknownTermination].contains(e)
        }
        
        return false
    }
        
    /// Add new location
    /// - Parameter coordinate: data
    @MainActor
    private func add(_ coordinate : CLLocation) {
        locations.append(coordinate)
    }
}

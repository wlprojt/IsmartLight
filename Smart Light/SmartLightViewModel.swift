import Foundation
import Combine

final class SmartLightViewModel: ObservableObject {
    
    @Published var isOn: Bool = false
    @Published var lastSeen: Date? = nil
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil

    private let deviceId: String
    private var dbPath: String { "devices/\(deviceId)/state" }

    init(deviceId: String) {
        self.deviceId = deviceId
        
        FirebaseManager.shared.configureIfNeeded()
        observeState()
    }

    private func observeState() {
        isLoading = true
        
        FirebaseManager.shared.observe(path: dbPath) { [weak self] value in
            DispatchQueue.main.async {
                guard let self = self else { return }
                defer { self.isLoading = false }

                if let dict = value as? [String: Any],
                   let isOn = dict["isOn"] as? Bool {
                    
                    self.isOn = isOn
                    if let ts = dict["lastSeen"] as? TimeInterval {
                        self.lastSeen = Date(timeIntervalSince1970: ts)
                    }

                } else {
                    // No data yet, set default
                    let defaultState: [String: Any] = [
                        "isOn": false,
                        "lastSeen": Date().timeIntervalSince1970
                    ]
                    FirebaseManager.shared.setValue(path: self.dbPath, value: defaultState)
                }
            }
        }
    }

    func toggle() {
        let newState = !isOn
        isOn = newState
        
        let payload: [String: Any] = [
            "isOn": newState,
            "lastSeen": Date().timeIntervalSince1970
        ]
        
        FirebaseManager.shared.setValue(path: dbPath, value: payload) { [weak self] err in
            DispatchQueue.main.async {
                if let err = err {
                    self?.errorMessage = "Update failed: \(err.localizedDescription)"
                }
            }
        }
    }
}


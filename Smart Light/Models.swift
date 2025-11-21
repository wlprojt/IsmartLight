import Foundation

struct SmartLightState: Codable {
    var isOn: Bool = false
    var lastSeen: TimeInterval? = nil
    
    func toDict() -> [String: Any] {
        return [
            "isOn": isOn,
            "lastSeen": lastSeen ?? Date().timeIntervalSince1970
        ]
    }
    
    static func from(_ dict: [String: Any]) -> SmartLightState {
        var s = SmartLightState()
        if let isOn = dict["isOn"] as? Bool { s.isOn = isOn }
        if let lastSeen = dict["lastSeen"] as? TimeInterval { s.lastSeen = lastSeen }
        return s
    }
}


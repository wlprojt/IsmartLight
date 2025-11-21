import Foundation
import FirebaseCore
import FirebaseDatabase

final class FirebaseManager {
    static let shared = FirebaseManager()
    private init() {}

    private var database: DatabaseReference? = nil

    // Call once from App init
    func configureIfNeeded() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }

        if database == nil {
            database = Database.database(
                url: "https://ismartlight-88e2a-default-rtdb.asia-southeast1.firebasedatabase.app"
            ).reference()
        }
    }

    func observe(path: String, callback: @escaping (Any?) -> Void) {
        guard let db = database else { return }
        db.child(path).observe(.value) { snapshot in
            callback(snapshot.value)
        }
    }

    func setValue(path: String, value: Any, completion: ((Error?) -> Void)? = nil) {
        guard let db = database else { return }
        db.child(path).setValue(value) { error, _ in
            completion?(error)
        }
    }

    func updateChildren(path: String, values: [String: Any], completion: ((Error?) -> Void)? = nil) {
        guard let db = database else { return }
        db.child(path).updateChildValues(values) { error, _ in
            completion?(error)
        }
    }
}


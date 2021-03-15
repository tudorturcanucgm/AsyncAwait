//
//  Motivation.swift
//  AsyncAwait
//
//  Created by Tudor Turcanu on 15.03.2021.
//

import _Concurrency
import Foundation

class Motivation {
    func getUserId(_ completion: @escaping (Int) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(12)
        }
    }

    func getUserFirstName(userId _: Int, _ completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("Tudor")
        }
    }

    func greetUser() {
        getUserId { [self] userId in
            getUserLastname(userId: userId) { lastName in
                getUserFirstName(userId: userId) { firstName in
                    print("Hello \(firstName) \(lastName)")
                }
            }
        }
    }

    func getUserLastname(userId _: Int, _ completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("Turcanu")
        }
    }

    func getUserId() async -> Int {
        return await withUnsafeContinuation { continuation in
            getUserId { userId in
                continuation.resume(returning: userId)
            }
        }
    }

    func getUserFirstName(userId: Int) async -> String {
        return await withUnsafeContinuation { continuation in
            getUserFirstName(userId: userId) { firstName in
                continuation.resume(returning: firstName)
            }
        }
    }

    func getUserLastName(userId: Int) async -> String {
        return await withUnsafeContinuation { continuation in
            getUserLastname(userId: userId) { lastName in
                continuation.resume(returning: lastName)
            }
        }
    }

    @asyncHandler func greetUserAwait() {
        let userId = await getUserId()
        let firstName = await getUserFirstName(userId: userId)
        let lastName = await getUserLastName(userId: userId)
        print("Hello \(firstName) \(lastName)")
    }

    @asyncHandler func greetUserAsync() {
        let userId = await getUserId()
        async let firstName = getUserFirstName(userId: userId)
        async let lastName = getUserLastName(userId: userId)

        await print("Hello \(firstName) \(lastName)")
    }
}

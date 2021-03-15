# AsyncAwait

[![iOS](https://img.shields.io/badge/platform-iOS_13+-blue.svg?style=flat)](https://developer.apple.com/ios/)
[![swift5.4](https://img.shields.io/badge/swift5.4-compatible-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Xcode 12.5 beta 3+](https://img.shields.io/badge/Xcode-12.5beta+-blue.svg?style=flat)](https://developer.apple.com/support/beta-software/)

# Problems with block-based APIs

- Pyramid of Doom 

```swift  
    func greetUser() {
        getUserId { [self] userId in
            getUserLastname(userId: userId) { lastName in
                getUserFirstName(userId: userId) { firstName in
                    print("Hello \(firstName) \(lastName)")
                }
            }
        }
    }
```
- Verbosity and old-style error handling

```swift
    func greetUser(completionBlock: (result: String?, error: NSError?) -> Void) {
        getUserId { [self] userId in
            guard let userId = userId else {
                handleNilUserId()
                return
            }
            getUserLastname(userId: userId) { lastName in
                getUserFirstName(userId: userId) { firstName in
                    print("Hello \(firstName) \(lastName)")
                }
            }
        }
    }
```
- Forget to call a completion handler

```swift
    func greetUser(completionBlock: (result: String?, error: NSError?) -> Void) {
        getUserId { [self] userId in
            guard let userId = userId else {
                return // <- forgot to call the block
            }
            getUserLastname(userId: userId) { lastName in
                getUserFirstName(userId: userId) { firstName in
                    let greet = "Hello \(firstName) \(lastName)"
                    completionBlock(greet, nil)
                }
            }
        }
    }
```
- Forget to return after calling a completion handler

```swift
    func greetUser(completionBlock: (result: String?, error: NSError?) -> Void) {
        getUserId { [self] userId in
            guard let userId = userId else {
                completionBlock(nil, Error("user cannot be nil")) // <- forgot to return after calling the block
            }
            getUserLastname(userId: userId) { lastName in
                getUserFirstName(userId: userId) { firstName in
                    let greet = "Hello \(firstName) \(lastName)"
                    completionBlock(greet, nil)
                }
            }
        }
    }
```
- Continuing on the wrong queue/thread

```swift
    func greetUser(completionBlock: (result: String?, error: NSError?) -> Void) {
        getUserId { [self] userId in
            getUserLastname(userId: userId) { lastName in
                getUserFirstName(userId: userId) { firstName in
                    let greet = "Hello \(firstName) \(lastName)"
                    DispatchQueue.main.async {
                        completionBlock(greet, nil)
                    }
                }
            }
        }
    }
```

# General use for async await

We can define an asynchronous function with the following syntax:

```swift  
func getUserId() async -> Int {
    sleep(3)
    return 1
}
```

The idea here is to include the async keyword alongside the return type since the call site will return when complete if we use the new await keyword.

To wait for the function to complete, we can use await:

```swift       
let userId = await getUserId()
```


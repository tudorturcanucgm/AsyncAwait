# AsyncAwait

[![iOS](https://img.shields.io/badge/platform-iOS_13+-blue.svg?style=flat)](https://developer.apple.com/ios/)
[![swift5.4](https://img.shields.io/badge/swift5.4-compatible-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Xcode 12.5 beta 3+](https://img.shields.io/badge/Xcode-12.5beta+-blue.svg?style=flat)](https://developer.apple.com/support/beta-software/)

# Motivation: Completion handlers are suboptimal

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

# General use

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


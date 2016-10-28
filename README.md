# KituraFlock

Automated deployment of your [Kitura](https://github.com/IBM-Swift/Kitura) server using [Flock](https://github.com/jakeheis/Flock).

## Installation
Add these lines to `deploy/FlockDependencies.json`:
```
"dependencies" : [
  ...
  {
    "name" : "https://github.com/jakeheis/KituraFlock",
    "version": "0.0.1"
  }
]
```
In your `Flockfile` add:
```swift
import Flock
import KituraFlock

...

Flock.use(Flock.Kitura)
```
Run `flock tools` again before deploying to install Kitura's tools on your server.
## Included tasks
```
kitura:tools    # Hooks .after("tools:dependencies")
kitura:stop     # Hooks .before("deploy:link")
kitura:start    # Hooks .after("deploy:link")
kitura:list
```

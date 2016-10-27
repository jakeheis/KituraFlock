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

## Included tasks
```
kitura:tools
kitura:stop
kitura:start
kitura:list
```

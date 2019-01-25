# NGLoggerKit

NGLoggerKit is a logger aggregator, with the possibility to add new output sources (files, remotes...) without having to go through all your app. It is designed to scale across large applications.

## Installation

### Carthage

```
github "Nuglif/NGLoggerKit"

```

### Cocoapods
```
pod 'NGLoggerKit', '~> 0.1'

```

## Getting Started


### How to use
```
let logger = LoggerBuilder().buildDefault(subSystem: "Sample")
```

**subsystem** is a user defined string describing which system is using the logger; larger apps can be composed of multiple subsystems each using a different logger (network module, ui module, persistence module, app module...).


And later you can use your new logger like this:

```
logger.info(SampleCategory.audio, "Hello world!")
```

> 2019-01-25 12:49:43.328314-0500 LoggerKit_Sample[70549:2430806] [Audio] Hello world!

**SampleCategory** is a user defined Category responding to LoggerKit's Category protocol.

### Provided Loggers

#### OSLogger

Prints to the system Console and XCode console using os.log API (available iOS 10.0). It is the **default logger** on iOS 10.0.

#### ConsoleLogger

Prints to XCode console. It is the default logger on iOS 9.0

#### FileLogger

### 

### Add your own logger

TODO

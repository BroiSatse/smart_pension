# SmartPension - coding challenge

This repository contains my solution to SmartPension coding challenge.

## Usage

```
./parse_log [options]
```

By default, the program will display non-unique visit counts in a tab-separated format. Following options are supported:

* ```-f FILE``` - adds a data source file
* ```--pretty``` - switches to more human-friendly display
* ```--unique``` - switches to unique visit counts

### Justification of design

I have decided to use ```-f``` switch, as there are many potential data sources program could use, including csv files, streams (pipe) or even internet. Those would be handled with additional flags in future versions.

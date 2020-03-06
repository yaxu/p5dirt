# p5dirt

A quick example for sending OSC messages to processing as well as superdirt.

You'll need to take your existing BootTidal.hs and change the startTidal bit to ...

```haskell
:{
tidal <- startMulti [superdirtTarget {oLatency = 0.2, oAddress = "127.0.0.1", oPort = 57120
                                     },
                     superdirtTarget {oLatency = 0.2, oAddress = "127.0.0.1", oPort = 2020,
                                      oTimestamp = NoStamp
                                     }
                    ] (defaultConfig {cFrameTimespan = 1/20})
:}
```

Then the included processing example will visualise events in each orbit as binary transitions.


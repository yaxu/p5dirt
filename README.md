# p5dirt

A quick example for sending OSC messages to processing as well as superdirt.

Save the BootTidal.hs file somewhere, and point your editor at it. For
example if you're using atom, open the preferences for the tidalcycles
package, and put the full path to the file (*including* the filename)
in the "Boot Tidal Path" setting.

Then restart atom.

With the included processing example, the following pattern should make
circles appear on the screen:

```
d1 $ slow 4 $ sound "bd*32"
  # pan sine
  # gain (slow 2 $ range 0.5 1 saw)
```

You can add in custom parameters for processing to work with, e.g.:

```
let scene = pS "scene"

d1 $ slow 4 $ sound "bd*32"
  # pan sine
  # gain (slow 2 $ range 0.5 1 saw)
  # scene "blue red"
```
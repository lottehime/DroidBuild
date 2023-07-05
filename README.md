DroidBuild
========
-------
Android emulator environment setup and build script for PS Vita and generic ARM WebKit PoC debugging and approximation.
-------

-------
Usage
-------

Setup your machine or VM with Ubuntu 12.04 first.

Run the script to setup and build a default image (4.0.1).
Use `--auto` to run the script in a mostly automated fashion.

-------
Important Notes
-------

If you wish to change the make parallelism, or to change the target Android version you wish to build then head to the commented section in the bottom end of the script.
Target versions can be found here: https://source.android.com/source/build-numbers.html

This has modifications of the env setup script by TEAM RADIUM (https://github.com/TeamRadium)

This hasn't been used in a while, so there may be broken parts. Don't say I didn't warn you! :D

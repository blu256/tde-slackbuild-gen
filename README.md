gentdesb
========

This is a script which automatically generates SlackBuilds for various TDE components (possibly even non-TDE, but I haven't tested). It can autodetect various types of build systems: CMake, Autotools, configure.py and setup.py.

I don't actually plan to spend a lot of time on this utility, but it does have some known issues:
 * It is not flexible nor configurable, you have to modify the `environ.sh` script to set up paths
 * Build options (e.g. debug) are not consistent between build systems
 * It doesn't compress man pages
   * Actually there is a skeleton of what was to be a configuration system, but I got lazy
 * It probably won't work with core packages (tqt, tdelibs, tdebase, tdegraphics, tdemultimedia etc.)
 * The code is overdue for a refactoring
 
Users interested in solving these issues and/or adding features are encouraged to do so by forking this repo, making their changes and then creating a pull request.

This program is licenced under 0-clause BSD.

Disclaimer
----------

I'm not responsible for anything that results from the usage of these scripts. I use this only for development and building applications that don't have their own SlackBuild scripts.

[Ray-V's SlackBuils](https://github.com/Ray-V/tde-slackbuilds) are a more preferrable choice.

*Remember that you have been warned.*


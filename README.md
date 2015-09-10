# DFLauncher
A simple launcher for Dwarf Fortress on OSX, for those who don't want to manually run the `df` file

## Backstory
I created this launcher to be able to simply run DF from the launchpad, without being forced to go in and find the `df` file every time I wanted to run the game.

## 1.2 Update
I noticed Dwarf Fortress doesn't run in a high enough resolution out of the box on retina devices. So to accomodate this a `Retina Mode` toggle has been added.

## 1.3 Update
Code has been significantly refactored to be less C-like and more Objective-C-like; a full-screen mode has also been added.

## Installation
Just drop `DFLauncher.app` into the same folder `df` resides in (it should be called `df_osx` unless you changed it)
* To obtain the file you need to compile it.
* Or you can grab it [here](https://drive.google.com/folderview?id=0BzCGYG05d-yGVFRWd2U2bFJuTmc&usp=sharing), but there's no guarantee it'll be the latest version
* If for some bizarre reason you can't run the app, run the following command in the terminal: <br>
  `chmod +x DFLauncher.app/Contents/MacOS/*`

## Credit
Credit for the icon goes to [cidrei](http://www.reddit.com/user/cidrei) on Reddit.

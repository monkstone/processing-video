# processing-video
Processing Video Library as a Maven Project. NB: this is not a fork of processing-library it is essentially a SNAPSHOT of https://github.com/processing/processing-video/releases/tag/r6-v2.0-beta4 src code, and my maven build.
To build:-
```bash
mvn package
```
To copy dependencies:-
```
mvn dependencies:copy-dependencies
```
video-4.0.jar is created in target folder

dependencies jars are version stripped and copied to library folder

copy video-4.0.jar to library/video.jar and you can the install library where required. Eg for PiCrate gem:-

`~/.picrate/libraries/video/library`

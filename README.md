Introduction
============

The idea is to implement an algorithm which takes a set of vocal-less songs from a music album and generates a new song that could have been a part of this album. In analysis phase, the algorithm starts by breaking a song into small windows in time. Then it tries to learn transitions of, energy and phase of frequencies for the given set of songs, using supervised machine learning. Next, in the generation phase, user gives initial energy and phase for frequencies to the algorithm and algorithm applies the transitions to these frequencies from window to window, producing a new song.


Architecture
============
Driver.m is the orchestrator of the process. It returns sampled data and saves generated song on disk.

Since Octave runs in single process and multiple predictions can be done at same time - so to use all available CPU threads a Java code was writtem which outputs multiple .m files which are predictors and can be run parallely in individula proceses. The only cavet is that do not start processing T+1th time bin unless prediction for Tth time bin is not over. Java code also creates an executor which takes care of this.

Dirver.m first samples the input song, saves the prediction data, runs the java code to generate predictors, run the predictorexecutor and finally consolidates data for all predictions and writes the generated song as wav file on the disk


TODO
====
- Make general folder for songs and program reads and loads them whithout intervention of user
- All folders should clean up after an execution
- user should be able to tell what is the duration of output song and how many predictions to be run in parallel

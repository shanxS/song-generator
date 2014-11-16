song-generator
==============

The idea is to implement an algorithm which takes a set of vocal-less songs from a music album and generates a new song that could have been a part of this album. In analysis phase, the algorithm starts by breaking a song into small windows in time. Then it tries to learn transitions of, energy and phase of frequencies for the given set of songs, using supervised machine learning. Next, in the generation phase, user gives initial energy and phase for frequencies to the algorithm and algorithm applies the transitions to these frequencies from window to window, producing a new song.



Java was used to generate Octave predictors to run predictions in parallel processes

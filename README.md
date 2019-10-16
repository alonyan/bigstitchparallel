# Big Stitcher Parallel
### These are functions and routines developed by Alon Oyler-Yaniv at the Wollman Lab at UCLA to streamline the processing of large, live, lightsheet datasets.

The pipeline is implemented in bash and is heavily dependent on [ImageJ](https://imagej.net/Welcome) and [Big Stitcher](https://imagej.net/BigStitcher).

These functions work in tandem with the data acquisition software [https://github.com/wollmanlab/Scope](https://github.com/wollmanlab/Scope) which automatically generates the parameters needed for processing.

#### To setup an analysis station follow these steps:
Start with a workstation running Ubuntu with a CUDA GPU

1. Install Nvidia drivers:
$ ubuntu-drivers devices
2. check that the device is recognized and driver is suggested
$ sudo ubuntu-drivers autoinstall
3. install nvidia-cuda-toolkit
$ sudo apt install nvidia-cuda-toolkit
4. install pip
5. install conda
6. install ImageJ
7. pip install git
8. git clone https://github.com/alonyan/bigstitchparallel /Documents/Repos/bigstitchparallel
9. sudo apt-get install xvfb
10. symlink ImageJ: sudo ln -s .../ImageJ-linux64 /usr/local/bin/ImageJ

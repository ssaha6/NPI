GENERAL INFORMATION
===================
This artifact has been designed and tested on the TACAS 2018 Artifact Evaluation
VM [1]. However, it is likely to run on any 64-bit Linux environment.

This artifact contains precompiled binaries (located in ./binaries) as well as
sources (located in ./sources). To reproduce the experimental results reported
in the paper, we highly recommend using the precompiled binaries! However, if
you want to compile the sources yourself, please follow the instructions at the
end of this document.

Our tool is build on top of the Boogie program verifier and the Z3 theorem
prover. These tools are interfaced via various scripts as described below.

[1] Hartmanns, Arnd; Wendler, Philipp (2018). figshare.
    https://doi.org/10.6084/m9.figshare.5896615


LICENSING
=========
- Our scripts are licensed under the Microsoft Public License (see LICENSE.txt).
- Please refer to the respective licenses for Microsoft Boogie, Micorosoft Z3,
  and Node.js.
- The Boogie prelude files and benchmarks for the natural proofs examples are
  taken from the VCDryad project (at https://github.com/edgar-pek/VCDryad) and
  fall under the same license.


REPRODUCING THE EXPERIMENTAL RESULTS
====================================
This artifact contains two sets of benchmarks: heap-manipulating programs
(located in ./heaps) and programs whose specifications involve universal
quantification (located in ./quantifier).

All benchmarks are provided as .bpl programs (Boogie verification language). In
the case of heap-manipulating programs, this archive also contains the original
C programs from which the .bpl programs have been generated using VCDryad. If
you want to do the natural proofs transformation and generation of Boogie
programs yourself, please follow the instructions at the end of this document.
The quantifier benchmarks were hand-crafted.

The artifact provides scripts to run a whole set of benchmarks (in ./heaps and
./quantifier, respectively). The process of running the experiments is the same
for both sets of benchmarks and consists of three steps:

1) Generation of predicates and insertion into the Boogie programs.
2) Verifying the programs, using Houdini to infer an adequate invariant.
3) Generating a report.

The exact commands slightly differ for both sets of benchmarks. In the
following, all commands are relative to the root directory of this artifact.
Depending on your computing power, running all experiments may take some time to
finish.

For heap-manipulating programs, run:

    cd heaps
    ./pred-gen-all.sh
    ./run-all.sh
    ../report-all.sh

For programs whose specifications involve universal quantification, run:

    cd quantifier
    ./enum-all.sh
    ./run-all.sh
    ../report-all.sh

If you want to run individual experiments, please consult the shell scripts
mentioned above. These scripts should be self-explanatory and contain all
necessary information. Basically, these scripts are a loop around ./houdini.sh.
To run an individual experiment, run ./houdini.sh with the desired input file.
Note that heap-benchmarks require a VCC prelude file to be given first (see
./heaps/run-all.sh for details). Also remember to save the output of Boogie to
an .out file in order to allow the report script to parse the results.


BUILDING SOURCES
================
To built the artifact from scratch, you need to compile Boogie and Z3. Creating
the .bpl files from the original C programs requires VCDryad. Download VCDryad
from https://github.com/edgar-pek/VCDryad and follow the instructions.

Building Boogie
---------------
To compile Boogie, you need a .NET compiler installed (the artifact VM has a
.NET compiler/runtime, mono, already installed). However, we recommend building
Boogie using Microsoft Visual Studio on Windows (the binaries are portable) as
many recent mono installations require complex configuration to build this
version of Boogie.

To compile Boogie on Windows, open the file Boogie.sln in sources/Boogie/Sources
and compiling the project. Alternatively, you can use the xbuild utility to
compile the sources from a Visual Studio command line (see compilation with mono
for more details).

To compile Boogie with mono, run:

    cd sources/Boogie/Sources
    xbuild Boogie.sln

After successful compilation, the binaries are located in
sources/Boogie/Binaries. Copy all files from this folder to ./binaries/boogie.

Building Z3
-----------
Compile Z3 by following the instructions in the file README.md in sources/Z3.

After successful compilation, copy the file z3 in ./sources/Z3/build to
./binaries/boogie. Rename z3 to z3.exe.
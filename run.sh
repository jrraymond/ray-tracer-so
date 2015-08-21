#!/bin/bash
mkdir profiling/$1
cabal configure --enable-executable-profiling --enable-library-profiling -f Profiling
cabal run -- +RTS -N2 -p -s -sstderr 2> profiling/$1/$1-stderr
mv img.ppm profiling/$1/$1.ppm
mv ray-tracer-so.prof profiling/$1/$1.prof
convert profiling/$1/$1.ppm  profiling/$1/$1.png
rm  profiling/$1/$1.ppm
cabal run -- +RTS -N2 -h 
mv ray-tracer-so.hp profiling/$1/$1.hp
#cabal run -- +RTS -hd
#mv ray-tracer-so.hp profiling/$1/$1-closure.hp
#cabal run -- +RTS -hy
#mv ray-tracer-so.hp profiling/$1/$1-type.hp
cabal configure -f Eventlog
cabal run -- +RTS -N2 -ls
mv ray-tracer-so.eventlog profiling/$1/$1.eventlog
cd profiling/$1/
hp2ps -c $1.hp
#hp2ps -c $1-closure.hp
#hp2ps -c $1-type.hp

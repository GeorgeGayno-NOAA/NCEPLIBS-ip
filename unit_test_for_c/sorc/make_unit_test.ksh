#!/bin/ksh --login

set -x

compiler=${compiler:-intel}

if [[ "$(hostname -f)" == g????.ncep.noaa.gov || \
      "$(hostname -f)" == t????.ncep.noaa.gov ]]; then  #WCOSS Phase 1/2
  case $compiler in
    intel)
      module purge
      module load ics
      module load sp ;;
  esac
elif [[ "$(hostname)" == slogin? || "$(hostname)" == llogin? ]]; then # WCOSS Cray ]]
  . /opt/modules/3.2.6.7/init/ksh
  case $compiler in
    intel) module purge
           module load PrgEnv-intel
           module load craype-sandybridge
           module load sp-intel/2.0.2 
           CCOMP="cc"
           CFLAGS="-std=c99" 
           LIBS="-lifcore" ;; 
    cray)  module purge
           module load PrgEnv-cray
           module load craype-haswell
           module load sp-cray-haswell/2.0.2 
           CCOMP="cc"
           CFLAGS=" " 
           LIBS=" " ;;
  esac
fi

CCOMP=${CCOMP:-icc}
CFLAGS=${CFLAGS:-"-std=c99"}
LIBS=${LIBS:-"-lifcore"}

SP_LIB4=${SP_LIB4:?}
SP_LIB8=${SP_LIB8:?}
SP_LIBd=${SP_LIBd:?}        # Mixed precision libraries

rm -f *.exe *.o
rm -f ../exec/*.exe

for precision in "4" "d" "8"
do
  case $precision in
    4) SP_LIB=$SP_LIB4 ;;
    8) SP_LIB=$SP_LIB8 ;;
    d) SP_LIB=$SP_LIBd ;;
  esac
  $CCOMP $CFLAGS -c -I../lib/incmod_${precision} test_gdswzd_${precision}.c
  $CCOMP test_gdswzd_${precision}.o ../lib/libip_${precision}.a ${SP_LIB} ${LIBS} -o test_gdswzd_${precision}.exe
  mv test_gdswzd_${precision}.exe ../exec
  rm -f *.o
done

 SUBROUTINE GAUSSLAT(JMAX,SLAT,WLAT)
!$$$  SUBPROGRAM DOCUMENTATION BLOCK
!
! $Revision$
! 
! SUBPROGRAM:  GAUSSLAT   COMPUTE GAUSSIAN LATITUDES
!   PRGMMR: IREDELL       ORG: W/NMC23       DATE: 92-04-16
!
! ABSTRACT: COMPUTES COSINES OF COLATITUDE AND GAUSSIAN WEIGHTS
!   ON THE GAUSSIAN LATITUDES.  THE GAUSSIAN LATITUDES ARE AT
!   THE ZEROES OF THE LEGENDRE POLYNOMIAL OF THE GIVEN ORDER.
!
! PROGRAM HISTORY LOG:
!   92-04-16  IREDELL
!   97-10-20  IREDELL  INCREASED PRECISION
! 1999-08-18  IREDELL  CALLED SPLAT
!
! USAGE:    CALL GAUSSLAT(JMAX,SLAT,WLAT)
!
!   INPUT ARGUMENT LIST:
!     JMAX     - INPUT NUMBER OF LATITUDES.
!
!   OUTPUT ARGUMENT LIST:
!     SLAT     - REAL (K) COSINES OF COLATITUDE.
!     WLAT     - REAL (K) GAUSSIAN WEIGHTS.
!
! SUBPROGRAMS CALLED:
!   SPLAT        COMPUTE LATITUDE FUNCTIONS
!
! ATTRIBUTES:
!   LANGUAGE: FORTRAN 90
!
!$$$
 IMPLICIT NONE
!
 INTEGER,           INTENT(IN   ) :: JMAX
!
 REAL,              INTENT(OUT  ) :: SLAT(JMAX),WLAT(JMAX)
!
 CALL SPLAT(4,JMAX,SLAT,WLAT)
!
 RETURN
 END SUBROUTINE GAUSSLAT

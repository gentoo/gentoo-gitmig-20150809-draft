#!/bin/sh
#	Key Expires ---> 2005 Mar  5 06:20:00
#
CDR_SECURITY=8:dvd,clone:sparc-sun-solaris2,i386-pc-solaris2,i586-pc-linux,powerpc-apple,hppa,powerpc-ibm-aix,i386-unknown-freebsd,i386-unknown-openbsd,i386-unknown-netbsd,powerpc-apple-netbsd,i386-pc-bsdi,mips-sgi-irix,i386-pc-sco:1.11::1110000000:::private/research/educational_non-commercial_use:1p8anqnRQ3jtiMgniHZLFfWSyfs2L.m4ab/OAUHU95PYL.SF7W2NAIDkJ/A
export CDR_SECURITY
exec cdrecord-ProDVD "$@"

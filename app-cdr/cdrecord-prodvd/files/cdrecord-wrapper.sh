#!/bin/sh
#	Key Expires ---> 2004 Aug 20 13:06:40
#
CDR_SECURITY=8:dvd,clone:sparc-sun-solaris2,i386-pc-solaris2,i586-pc-linux,powerpc-apple,hppa,powerpc-ibm-aix,i386-unknown-freebsd,i386-unknown-openbsd,i386-unknown-netbsd,powerpc-apple-netbsd,i386-pc-bsdi,mips-sgi-irix,i386-pc-sco:1.11::1093000000:::private/research/educational_non-commercial_use:9vl2T2kP6w6O4h.bXuet8hP1Z3H5erm3qWmxhbcr.fHvuN8ZJbhQUWBzjAc
export CDR_SECURITY
exec cdrecord-ProDVD "$@"

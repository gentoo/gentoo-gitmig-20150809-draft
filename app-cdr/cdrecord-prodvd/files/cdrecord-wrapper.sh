#!/bin/sh
#	Key Expires ---> 2006 Jun 11 06:26:40
#

CDR_SECURITY=8:dvd,clone:sparc-sun-solaris2,i386-pc-solaris2,i586-pc-linux,x86_64-unknown-linux,x86_64-pc-linux,powerpc-apple,hppa,powerpc-ibm-aix,i386-unknown-freebsd,i386-unknown-openbsd,i386-unknown-netbsd,powerpc-apple-netbsd,i386-pc-bsdi,mips-sgi-irix,i386-pc-sco,i586-pc-cygwin:1.11::1160000000:::private/research/educational_non-commercial_use:7mdYPOtM7xevuyXKvT9rNV.x3B6SFV4MLrduxvxrhbY2X9ddw/oqJyoXZW/

export CDR_SECURITY
exec cdrecord-ProDVD "$@"

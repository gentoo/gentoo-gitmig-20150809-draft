#!/bin/sh
#	Key Expires ---> 2005 Oct 22 18:53:20
#
CDR_SECURITY=8:dvd,clone:sparc-sun-solaris2,i386-pc-solaris2,i586-pc-linux,powerpc-apple,hppa,powerpc-ibm-aix,i386-unknown-freebsd,i386-unknown-openbsd,i386-unknown-netbsd,powerpc-apple-netbsd,i386-pc-bsdi,mips-sgi-irix,i386-pc-sco,i586-pc-cygwin:1.11::1130000000:::private/research/educational_non-commercial_use:4Yrzy07SJ6rmjHWclTIMRj9IPRFm1dbW9E3QNK/HtzKg6Sr0h7Qj88980Fo
export CDR_SECURITY
exec cdrecord-ProDVD "$@"

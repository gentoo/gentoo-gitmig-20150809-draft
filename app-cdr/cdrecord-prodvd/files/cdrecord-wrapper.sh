#!/bin/sh
CDR_SECURITY=8:dvd,clone:sparc-sun-solaris2,i386-pc-solaris2,i586-pc-linux,i686-pc-linux,powerpc-apple,hppa,powerpc-ibm-aix,i386-unknown-freebsd,i386-unknown-openbsd,i386-unknown-netbsd,powerpc-apple-netbsd,i386-pc-bsdi,mips-sgi-irix,i386-pc-sco:1.11::1076000000:::private/research/educational_non-commercial_use:5kiG6nW75l/om7C5dFGBTglXcWO1xJr2ZPcXcVjv1XK7Hk/rd4GtmxgLrhN
export CDR_SECURITY
exec cdrecord-ProDVD "$@"

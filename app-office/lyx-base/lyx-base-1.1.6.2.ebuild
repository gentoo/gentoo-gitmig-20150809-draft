# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $ /home/cvsroot/gentoo-x86/skel.build,v 1.3 2001/07/05 02:43:36 drobbins Exp$

# The real version of LyX is 1.1.6fix2. As Portage has no support for
# arbitrary suffixes like 'fix' (yet), this is translated into 1.1.6.2.
P=lyx-1.1.6fix2
A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="LyX is an Xwindows graphical frontend for LaTeX. Instead\
	     of forcing you to learn LaTeX markup syntax and use the\
	     proper tags, however, it is a WYSIWYM program."

SRC_URI="ftp://ftp.lyx.org/pub/${A}"

HOMEPAGE="http://www.lyx.org/"

# This lyx-base ebuild only depends on the absolutely necessary packages.
# The acompanying lyx-utils ebuild depends on lyx-base and on everything
# else that lyx can use.
DEPEND="virtual/x11
	x11-libs/xforms
	app-text/tetex 
	>=sys-devel/perl-5
	sys-devel/gcc
	sys-libs/glibc
	sys-devel/ld.so"

src_compile() {

    try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
    
    try emake
        
}

src_install () {
    
    # install-strip is a special target provided by the LyX makefile
    # for striping installed binaries.
    try make DESTDIR=${D} install-strip

}


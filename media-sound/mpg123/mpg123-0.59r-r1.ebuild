# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Id: mpg123-0.59r-r1.ebuild,v 1.3 2002/05/09 23:48:34 blauwers Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Real Time mp3 player"
SRC_URI="http://www.mpg123.de/mpg123/${P}.tar.gz"
HOMEPAGE="http://www.mpg123.de/"

DEPEND="virtual/glibc"

src_unpack () {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-sparc.diff
	cp Makefile Makefile.orig
	sed -e "s:-O2 -m486:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	local MAKEOPT=""
	local MAKESTYLE=""

	SYSTEM_ARCH=`echo $ARCH |\
		sed -e s/[i]*.86/i386/ \
			-e s/sun.*/sparc/ \
			-e s/arm.*/arm/ \
			-e s/sa110/arm/`

	if [ -z "$SYSTEM_ARCH" ]
	then
		SYSTEM_ARCH=`uname -m |\
		sed -e s/[i]*.86/i386/ -e s/arm.*/arm/ -e s/sa110/arm/`
	fi 

	case $SYSTEM_ARCH in 
	  ppc) 
	   MAKESTYLE="-ppc";;
	  i386)
	   MAKESTYLE="-i486";;
	  sparc64)
	   MAKESTYLE="-sparc";;
	  sparc)
	   MAKESTYLE="-sparc";;
	  arm)
	   ;; 
	esac

	make linux${MAKESTYLE}${MAKEOPT} || die
}

src_install () {
	into /usr
	dobin mpg123
	doman mpg123.1
	dodoc BENCHMARKING BUGS CHANGES COPYING JUKEBOX README* TODO
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-0.59s.ebuild,v 1.2 2003/09/07 00:06:06 msterret Exp $

S=${WORKDIR}/mpg123

DESCRIPTION="Real Time mp3 player"
SRC_URI="http://www.mpg123.de/mpg123/${PN}-pre${PV}.tar.gz"
HOMEPAGE="http://www.mpg123.de/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

src_unpack () {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2 -m486:${CFLAGS}:" \
		-e "s:-O2 -mcpu=ppc:${CFLAGS}:g" Makefile.orig > Makefile
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
	   if [ -z "use mmx" ]
	   then
	    MAKESTYLE="-mmx"
	   else
	     MAKESTYLE="-i486"
	   fi;;
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


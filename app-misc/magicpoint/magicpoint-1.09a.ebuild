# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicpoint/magicpoint-1.09a.ebuild,v 1.4 2002/07/26 01:52:49 kabau Exp $

S=${WORKDIR}/${P}
DESCRIPTION="an X11 based presentation tool"
SRC_URI="ftp://ftp.mew.org/pub/MagicPoint/${P}.tar.gz"
HOMEPAGE="http://www.mew.org/mgp/"

DEPEND="virtual/glibc virtual/x11
	ungif? ( >=media-libs/libungif-4.0.1 )
	gif?   ( >=media-libs/giflib-4.0.1 )"

RDEPEND=""

SLOT="0"
LICENSE="Sleepycat"
KEYWORDS="x86"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

DEPEND="virtual/x11
	ungif? ( >=media-libs/libungif-4.0.1 )
	gif?	 ( >=media-libs/giflib-4.0.1 )"

src_compile() {
	 
	export LIBS="-L/usr/lib/ -L/usr/X11R6/lib/ -lX11"
	if [ "`use gif`" ] && [ "`use ungif`" ] ; then
		GIF_FLAG="--enable-gif";
	else
		GIF_FLAG="--disable-gif";
	fi

	./configure --with-x ${GIF_FLAG} || die
	xmkmf || die
	make Makefiles || die
	make clean || die
	make ${MAKEOPTS} || die
}

src_install() {								 
	make DESTDIR=${D} install || die
	make DESTDIR=${D} DOCHTMLDIR=/usr/share/doc/${P} \
		MANPATH=/usr/share/man MANSUFFIX=1 install.man || die

	dodoc COPYRIGHT* FAQ README* RELNOTES SYNTAX TODO* USAGE*
}

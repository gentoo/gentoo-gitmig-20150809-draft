# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicpoint/magicpoint-1.09a-r1.ebuild,v 1.4 2002/07/26 01:52:49 kabau Exp $

S=${WORKDIR}/${P}
DESCRIPTION="an X11 based presentation tool"
SRC_URI="ftp://ftp.mew.org/pub/MagicPoint/${P}.tar.gz"
HOMEPAGE="http://www.mew.org/mgp/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

DEPEND="virtual/x11
	gif? ( >=media-libs/libungif-4.0.1 )
	imlib? ( media-libs/imlib )
	truetype? ( >=media-libs/freetype-1.3.1 )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="Sleepycat"
KEYWORDS="x86"

src_compile() {
 	
	local myconf

	use gif	\
		&& myconf="${myconf} --enable-gif"	\
		|| myconf="${myconf} --disable-gif"

	use imlib	\
		&& myconf="${myconf} --enable-imlib"	\
		|| myconf="${myconf} --disable-imlib"

	use truetype	\
		&& myconf="${myconf} --enable-freetype"	\
		|| myconf="${myconf} --disable-freetype"

	use nls	\
		&& myconf="${myconf} --enable-locale"	\
		|| myconf="${myconf} --disable-locale"

	export LIBS="-L/usr/lib/ -L/usr/X11R6/lib/ -lX11"

	./configure	\
		--with-xa	\
		${myconf} || die
	
	xmkmf || die
	make Makefiles || die
	make clean || die
	make || die
}

src_install() {                               
	make 	\
		DESTDIR=${D}	\
		install || die

	make 	\
		DESTDIR=${D}	\
		DOCHTMLDIR=/usr/share/doc/${P}	\
		MANPATH=/usr/share/man	\
		MANSUFFIX=1	\
		install.man || die

	dodoc COPYRIGHT* FAQ README* RELNOTES SYNTAX TODO* USAGE*
}

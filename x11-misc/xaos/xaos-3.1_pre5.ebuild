# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xaos/xaos-3.1_pre5.ebuild,v 1.1 2003/03/12 10:01:10 george Exp $

IUSE="X svga aalib ggi"

PN=XaoS
PV=3.1pre5
P=${PN}-${PV}
S=${WORKDIR}/${P}

DESCRIPTION="A very fast real-time fractal zoomer"
HOMEPAGE="http://sourceforge.net/projects/xaos/"
SRC_URI="mirror://sourceforge/xaos/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="X? ( virtual/x11 )
	svga? ( >=media-libs/svgalib-1.4.3 )
	aalib? ( media-libs/aalib )
	ggi?   ( media-libs/libggi )
	sys-libs/zlib
	media-libs/libpng"


src_compile() {
	local myconf
	use X     || myconf="--with-x11-driver=no"
#	use dga   || myconf="${myconf} --with-dga-driver=no"
	use ggi   || myconf="${myconf} --with-ggi-driver=no"
	use svga  || myconf="${myconf} --with-svga-driver=no"
#	use aalib || myconf="${myconf} --with-aa-driver=no"

	#i18n support is quite broken in XaoS, it gets installed
	#anyway, so we remove it later during install if not desired
	use nls   || myconf="${myconf} --with-i18n=no"

	./configure --prefix=/usr ${myconf} && make || die
}

src_install() {
	# these get installed, assuming that the directories exist!
	mkdir -p ${D}/usr/share/locale/{hu,es,fr,cs,de}/LC_MESSAGES
	mkdir -p ${D}/usr/share/{man,info}
	make \
		prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
 		LOCALEDIR=${D}/usr/share/locale \
	install || die

	use nls || rm -r ${D}/usr/share/locale

	dodoc ChangeLog* COPYING INSTALL* TODO*
}

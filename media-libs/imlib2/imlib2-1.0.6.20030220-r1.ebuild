# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.0.6.20030220-r1.ebuild,v 1.6 2003/08/26 03:49:20 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~mips ~arm ~hppa ~sparc amd64"
IUSE="mmx gif png jpeg tiff static X"

DEPEND="=media-libs/freetype-1*
	gif? ( media-libs/libungif
		>=media-libs/giflib-4.1.0 )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( media-libs/jpeg )
	tiff? ( >=media-libs/tiff-3.5.5 )
	virtual/x11"

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586
[ $ARCH = alpha ] && append-flags -fPIC

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env USER=blah WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	local myconf="--sysconfdir=/etc/X11/imlib --with-gnu-ld"
	myconf="${myconf} `use_enable mmx` `use_with X x`"
	econf ${myconf} || die "could not configure"
	emake || die "could not make"
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc/X11/imlib install || die
	dodoc AUTHORS ChangeLog README TODO
	dohtml -r doc
	docinto samples
	dodoc demo/*.c
}

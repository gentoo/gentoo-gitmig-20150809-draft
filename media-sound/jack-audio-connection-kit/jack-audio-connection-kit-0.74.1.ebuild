# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.74.1.ebuild,v 1.2 2003/07/24 12:21:51 torbenh Exp $

IUSE="doc debug"

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"

DEPEND=">=media-libs/alsa-lib-0.9.1
	>=media-libs/libsndfile-1.0.0
	dev-libs/glib
	dev-util/pkgconfig
	sys-libs/ncurses
	doc? ( app-doc/doxygen )
	!media-sound/jack-cvs"
PROVIDE="virtual/jack"

src_compile() {
	local myconf
	myconf="--with-gnu-ld"

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "configure failed"

	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README AUTHORS TODO

	# Remove installed html docs as we have our own routine
	if [ -d ${D}/usr/share/jack-audio-connection-kit/ ]; then
		rm -rf ${D}/usr/share/jack-audio-connection-kit/
	fi

	use doc && dohtml ${S}/doc/reference/html/*
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.2.4-r1.ebuild,v 1.1 2003/09/10 04:08:12 vapier Exp $

DESCRIPTION="Library for overlaying text/glyphs in X-Windows \
X-On-Screen-Display plus binary for sending text from command line."
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="http://ftp.debian.org/debian/pool/main/x/xosd/${PN}_${PV}.orig.tar.gz"

IUSE="xmms"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="virtual/x11
	xmms? ( media-sound/xmms
		>=media-libs/gdk-pixbuf-0.22.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-font-align.patch
}

src_compile() {
	if [ "`use xmms`" ]; then
		myconf="--with-plugindir=/usr/lib/xmms/General"
	else
		myconf="--without-plugindir"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS COPYING README
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.2.14.ebuild,v 1.1 2005/03/25 11:46:20 lanius Exp $

inherit eutils

IUSE="xinerama xmms bmp"

DESCRIPTION="Library for overlaying text/glyphs in X-Windows X-On-Screen-Display plus binary for sending text from command line"
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="mirror://debian/pool/main/x/xosd/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/xosd/${PN}_${PV}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~hppa ~ia64 ~amd64 ~ppc64"

DEPEND="virtual/x11
	bmp? (media-sound/beep-media-player >=media-libs/gdk-pixbuf-0.22.0 )
	xmms? ( media-sound/xmms >=media-libs/gdk-pixbuf-0.22.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/2.2.8-xmms-trackpos.patch
	epatch ${DISTDIR}/${PN}_${PV}-1.diff.gz
}

src_compile() {
	local myconf=""

	use xinerama || myconf="${myconf} --disable-xinerama"

	use xmms || myconf="${myconf} --disable-new-plugin"
	use bmp || myconf="${myconf} --disable-beep_media_player"


	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS COPYING README TODO
}

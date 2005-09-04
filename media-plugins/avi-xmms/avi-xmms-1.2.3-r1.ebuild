# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/avi-xmms/avi-xmms-1.2.3-r1.ebuild,v 1.10 2005/09/04 10:05:56 flameeyes Exp $

inherit eutils flag-o-matic

DESCRIPTION="A xmms plugin for AVI/DivX movies"
SRC_URI="http://www.xmms.org/files/plugins/avi-xmms/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
# Contains x86 assembly
KEYWORDS="-x86 -*"

DEPEND=">=media-sound/xmms-1.2.7-r13
	media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd ${S}
	# various C++ language fixes
	epatch ${FILESDIR}/avi-xmms-1.2.3-gcc3-gentoo.patch
}

src_compile() {
	filter-flags -fno-exceptions

	econf || die
	emake -j1 || die
}

src_install () {
	make libdir=/usr/lib/xmms/Input DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.12-r1.ebuild,v 1.6 2008/11/15 18:42:10 dertobi123 Exp $

inherit eutils

DESCRIPTION="Library of cd audio related routines"
HOMEPAGE="http://libcdaudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.99-CAN-2005-0706.patch #84936
	epatch "${FILESDIR}"/${P}-bug245649.patch
}

src_compile() {
	econf --enable-threads || die "configure failed"
	emake || die "compile problem."
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangLog NEWS README TODO
}
